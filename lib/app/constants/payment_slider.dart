import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentConfirmationSlider extends StatefulWidget {
  final RxBool isPaymentConfirmed;

  const PaymentConfirmationSlider({Key? key, required this.isPaymentConfirmed}) : super(key: key);

  @override
  _PaymentConfirmationSliderState createState() => _PaymentConfirmationSliderState();
}

class _PaymentConfirmationSliderState extends State<PaymentConfirmationSlider> {
  bool _isDragging = false;
  double _dragPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final double sliderWidth = MediaQuery.of(context).size.width * 0.8;
    final double thumbSize = 40.0;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _isDragging = true;
          _dragPosition += details.delta.dx;
          _dragPosition = _dragPosition.clamp(0.0, sliderWidth - thumbSize);
        });
      },
      onHorizontalDragEnd: (details) {
        if (_dragPosition > (sliderWidth - thumbSize) * 0.8) {
          widget.isPaymentConfirmed.value = true;
        } else {
          _resetSlider();
        }
      },
      child: Container(
        width: sliderWidth,
        height: 50,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: widget.isPaymentConfirmed.value ? Colors.green : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.isPaymentConfirmed.value ? "Payment Confirmed" : "Slide to Confirm Payment",
                style: TextStyle(
                  color: widget.isPaymentConfirmed.value ? Colors.white : Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: _isDragging ? 0 : 300),
              curve: Curves.easeOut,
              left: widget.isPaymentConfirmed.value
                  ? sliderWidth - thumbSize - 4
                  : _dragPosition,
              top: 0,
              child: Container(
                width: thumbSize,
                height: thumbSize,
                decoration: BoxDecoration(
                  color: widget.isPaymentConfirmed.value ? Colors.white : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Icon(
                  widget.isPaymentConfirmed.value ? Icons.check : Icons.arrow_forward_ios,
                  color: widget.isPaymentConfirmed.value ? Colors.green : Colors.black54,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetSlider() {
    setState(() {
      _isDragging = false;
      _dragPosition = 0.0;
    });
  }
}
