import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seeds/components/full_page_loading_indicator.dart';
import 'package:seeds/constants/app_colors.dart';
import 'package:seeds/datasource/local/settings_storage.dart';
import 'package:seeds/datasource/remote/model/transaction_results.dart';
import 'package:seeds/domain-shared/app_constants.dart';
import 'package:seeds/domain-shared/page_command.dart';
import 'package:seeds/domain-shared/page_state.dart';
import 'package:seeds/navigation/navigation_service.dart';
import 'package:seeds/screens/explore_screens/p2p/interactor/viewmodels/p2p_bloc.dart';
import 'package:seeds/screens/transfer/send/send_confirmation/interactor/viewmodels/send_confirmation_arguments.dart';
import 'package:webview_flutter/webview_flutter.dart';

class P2PScreen extends StatefulWidget {
  const P2PScreen({Key? key}) : super(key: key);

  @override
  _P2PScreenState createState() => _P2PScreenState();
}

class _P2PScreenState extends State<P2PScreen> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => P2PBloc(),
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<P2PBloc, P2PState>(
            listenWhen: (_, current) => current.pageCommand != null,
            listener: (context, state) async {
              final pageCommand = state.pageCommand;
              if (pageCommand is NavigateToRouteWithArguments) {
                final TransactionResult? result = await NavigationService.of(context)
                    .navigateTo(pageCommand.route, SendConfirmationArguments(transaction: pageCommand.arguments));
                if (result != null) {
                  await _webViewController.runJavascript(
                      "setResponseCallbackLW({status: '${result.status.name}', message:'${result.message}'})");
                }
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  WebView(
                    initialUrl: p2pAppUrl,
                    backgroundColor: AppColors.primary,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (webViewController) => _webViewController = webViewController,
                    onPageStarted: (url) => print('Page started loading: $url'),
                    onProgress: (progress) => print('WebView is loading (progress : %$progress)'),
                    onPageFinished: (_) => BlocProvider.of<P2PBloc>(context).add(const OnPageLoaded()),
                    onWebResourceError: (error) => print(error),
                    javascriptChannels: {
                      JavascriptChannel(
                        name: 'onSignTransactions',
                        onMessageReceived: (javascriptMessage) {
                          BlocProvider.of<P2PBloc>(context).add(OnMessageReceived(javascriptMessage));
                        },
                      ),
                      JavascriptChannel(
                        name: 'onLogin',
                        onMessageReceived: (_) async {
                          await _webViewController
                              .runJavascript("setAccountNameFromLw('${settingsStorage.accountName}')");
                        },
                      )
                    },
                  ),
                  if (state.pageState == PageState.loading) const FullPageLoadingIndicator()
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}