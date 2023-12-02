import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/com_utils.dart';
import '../provider/base_provider.dart';

class BaseProviderView<T extends BaseProvider> extends StatefulWidget {
  const BaseProviderView({
    super.key,
    required this.builder,
    required this.provider,
  });

  final Widget builder;
  final T provider;

  @override
  // ignore: library_private_types_in_public_api
  _BaseProviderViewState<T> createState() => _BaseProviderViewState<T>();
}

class _BaseProviderViewState<T extends BaseProvider>
    extends State<BaseProviderView<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.provider,
      child: GestureDetector(
        onTap: () => CommonUtils.unfocusKeyboard(context),
        child: widget.builder,
      ),
    );
  }
}
