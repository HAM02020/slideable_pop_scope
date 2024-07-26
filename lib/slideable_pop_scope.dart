library slideable_pop_scope;

import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SlideablePopScope extends StatefulWidget {
  /// Creates a widget that registers a callback to veto attempts by the user to
  /// dismiss the enclosing [ModalRoute].
  const SlideablePopScope({
    super.key,
    required this.child,
    this.canPop = true,
    this.onPopInvoked,
    this.onWillPop,
  });

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// {@template flutter.widgets.PopScope.onPopInvoked}
  /// Called after a route pop was handled.
  /// {@endtemplate}
  ///
  /// It's not possible to prevent the pop from happening at the time that this
  /// method is called; the pop has already happened. Use [canPop] to
  /// disable pops in advance.
  ///
  /// This will still be called even when the pop is canceled. A pop is canceled
  /// when the relevant [Route.popDisposition] returns false, such as when
  /// [canPop] is set to false on a [PopScope]. The `didPop` parameter
  /// indicates whether or not the back navigation actually happened
  /// successfully.
  ///
  /// See also:
  ///
  ///  * [Route.onPopInvoked], which is similar.
  final PopInvokedCallback? onPopInvoked;

  final FutureOr<bool> Function()? onWillPop;

  /// {@template flutter.widgets.PopScope.canPop}
  /// When false, blocks the current route from being popped.
  ///
  /// This includes the root route, where upon popping, the Flutter app would
  /// exit.
  ///
  /// If multiple [PopScope] widgets appear in a route's widget subtree, then
  /// each and every `canPop` must be `true` in order for the route to be
  /// able to pop.
  ///
  /// [Android's predictive back](https://developer.android.com/guide/navigation/predictive-back-gesture)
  /// feature will not animate when this boolean is false.
  /// {@endtemplate}
  final bool canPop;

  @override
  State<SlideablePopScope> createState() => _SlideablePopScopeState();
}

class _SlideablePopScopeState extends State<SlideablePopScope>
    implements PopEntry {
  ModalRoute<dynamic>? _route;

  @override
  PopInvokedCallback? get onPopInvoked => (bool didPop) async {
        if (didPop) return;
        widget.onPopInvoked?.call(didPop);
        final onWillPop = widget.onWillPop;
        if (onWillPop != null) {
          if (await onWillPop.call()) {
            if (mounted) {
              Navigator.pop(context);
            }
          }
        }
      };

  @override
  late final ValueNotifier<bool> canPopNotifier;

  @override
  void initState() {
    super.initState();
    canPopNotifier =
        ValueNotifier<bool>(widget.onWillPop != null ? false : widget.canPop);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ModalRoute<dynamic>? nextRoute = ModalRoute.of(context);
    if (nextRoute != _route) {
      _route?.unregisterPopEntry(this);
      _route = nextRoute;
      _route?.registerPopEntry(this);
    }
  }

  @override
  void didUpdateWidget(SlideablePopScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    canPopNotifier.value =widget.onWillPop != null ? false : widget.canPop;
  }

  @override
  void dispose() {
    _route?.unregisterPopEntry(this);
    canPopNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    if (Platform.isIOS) {
      child = RawGestureDetector(
        gestures: {
          _SDSlideBackGestureRecognizer: GestureRecognizerFactoryWithHandlers<
                  _SDSlideBackGestureRecognizer>(
              () => _SDSlideBackGestureRecognizer(), (instance) {
            instance.onEnd = (detail) {
              Navigator.maybePop(context);
            };
          })
        },
        child: child,
      );
    }
    return child;
  }
}

class _SDSlideBackGestureRecognizer extends HorizontalDragGestureRecognizer {
  @override
  bool isPointerAllowed(PointerEvent event) {
    bool res = super.isPointerAllowed(event);
    if (event.position.dx > 10) {
      res = false;
    }
    return res;
  }
}
