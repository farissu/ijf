import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'loadingapi_model.dart';
export 'loadingapi_model.dart';

class LoadingapiWidget extends StatefulWidget {
  const LoadingapiWidget({super.key});

  @override
  State<LoadingapiWidget> createState() => _LoadingapiWidgetState();
}

class _LoadingapiWidgetState extends State<LoadingapiWidget> {
  late LoadingapiModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingapiModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Lottie.network(
        'https://lottie.host/8c49ce0e-78d5-4d1d-b009-924ac46bf0d5/Q7IRQC5n22.json',
        width: 345.0,
        height: 299.0,
        fit: BoxFit.contain,
        animate: true,
      ),
    );
  }
}
