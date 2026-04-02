import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../otp_view_model.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.email,
    this.expireSeconds = 120,
  });

  final String email;
  final int expireSeconds;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  static const _length = 6;

  final _controllers = List.generate(_length, (_) => TextEditingController());
  final _focusNodes = List.generate(_length, (_) => FocusNode());

  late int _secondsLeft;
  Timer? _timer;

  bool get _isComplete => _controllers.every((c) => c.text.isNotEmpty);
  bool get _isExpired => _secondsLeft <= 0;

  String get _timerLabel {
    final m = _secondsLeft ~/ 60;
    final s = _secondsLeft % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.expireSeconds;
    _startTimer();
    for (var i = 0; i < _length; i++) {
      _focusNodes[i].onKeyEvent = (_, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            _controllers[i].text.isEmpty &&
            i > 0) {
          _focusNodes[i - 1].requestFocus();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      };
    }
    context.read<OtpViewModel>().addListener(_onViewModelChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  void _onViewModelChanged() {
    if (context.read<OtpViewModel>().isVerified) {
      context.go('/home'); // TODO: replace with actual home route
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        if (_secondsLeft > 0) _secondsLeft--;
      });
    });
  }

  void _resend() {
    setState(() {
      _secondsLeft = widget.expireSeconds;
      for (final c in _controllers) {
        c.clear();
      }
    });
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _focusNodes[0].requestFocus(),
    );
    context.read<OtpViewModel>().resendOtp(email: widget.email);
  }

  @override
  void dispose() {
    context.read<OtpViewModel>().removeListener(_onViewModelChanged);
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    final vm = context.read<OtpViewModel>();
    if (vm.errorMessage != null) {
      vm.clearError();
    }

    // Handle paste: distribute digits across boxes
    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'\D'), '');
      for (var i = 0; i < _length && i < digits.length; i++) {
        _controllers[i].text = digits[i];
      }
      final next = (digits.length - 1).clamp(0, _length - 1);
      _focusNodes[next].requestFocus();
      setState(() {});
      return;
    }

    if (value.isNotEmpty && index < _length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    setState(() {});
  }

  void _submit() {
    if (!_isComplete || _isExpired) return;
    final code = _controllers.map((c) => c.text).join();
    context.read<OtpViewModel>().verifyOtp(
          email: widget.email,
          otp: code,
        );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final vm = context.watch<OtpViewModel>();
    final isLoading = vm.isLoading;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // ── Branding area (top) ──────────────────────────
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            'assets/images/logo2.png',
                            width: 180,
                            height: 180,
                          ),
                        ),
                      ),

                      // ── Form area (bottom) ───────────────────────────
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verify your email',
                              style: textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text.rich(
                              TextSpan(
                                text: 'Enter the 6-digit code sent to ',
                                style: textTheme.bodyMedium
                                    ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                                children: [
                                  TextSpan(
                                    text: widget.email,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),

                            // OTP boxes
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(_length, (i) {
                                return _OtpBox(
                                  controller: _controllers[i],
                                  focusNode: _focusNodes[i],
                                  onChanged: (v) => _onChanged(i, v),
                                  enabled: !_isExpired && !isLoading,
                                );
                              }),
                            ),

                            const SizedBox(height: 16),

                            // Timer / expired indicator
                            Center(
                              child: _isExpired
                                  ? Text(
                                      'Code expired',
                                      style: textTheme.bodySmall?.copyWith(
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.timer_outlined,
                                          size: 14,
                                          color: _secondsLeft <= 30
                                              ? Colors.redAccent
                                              : Colors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          _timerLabel,
                                          style: textTheme.bodySmall?.copyWith(
                                            color: _secondsLeft <= 30
                                                ? Colors.redAccent
                                                : Colors.grey,
                                            fontWeight: FontWeight.w600,
                                            fontFeatures: const [
                                              FontFeature.tabularFigures(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            ),

                            // Error banner
                            if (vm.errorMessage != null) ...[
                              const SizedBox(height: 16),
                              _ErrorBanner(message: vm.errorMessage!),
                            ],

                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: (_isComplete && !_isExpired && !isLoading)
                                    ? _submit
                                    : null,
                                child: isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text('Verify'),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),

                      // ── Bottom link ──────────────────────────────────
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive a code?",
                              style: textTheme.bodyMedium,
                            ),
                            TextButton(
                              onPressed: _resend,
                              child: const Text('Resend'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.redAccent.shade100),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.redAccent, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _OtpBox extends StatefulWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.enabled,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final bool enabled;

  @override
  State<_OtpBox> createState() => _OtpBoxState();
}

class _OtpBoxState extends State<_OtpBox> {
  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() => setState(() {});

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = widget.focusNode.hasFocus;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: widget.enabled ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isFocused ? Colors.black : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          filled: false,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: widget.onChanged,
      ),
    );
  }
}
