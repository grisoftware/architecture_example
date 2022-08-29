import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/config/dependency/injectable.dart';
import '../../domain/entities/short_link_entity.dart';
import '../constants.dart';
import '../texts.dart';
import '../widget/default_button.dart';
import 'bloc/home_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final EdgeInsets padding = MediaQuery.of(context).padding;

    return BlocProvider(
      create: (_) => getIt<HomeBloc>()..add(Init()),
      child: BlocBuilder<HomeBloc, HomeState>(builder: (_, state) {
        final HomeBloc homeBloc = _.read<HomeBloc>();
        void _addEvent(HomeEvent event) => _.read<HomeBloc>().add(event);
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: state.shortLinks.isEmpty
                    ? Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(height: padding.top + 50),
                                Center(
                                    child: SvgPicture.asset(
                                  'assets/shortly.svg',
                                  width: size.width * 0.8,
                                )),
                                const SizedBox(height: 20),
                                // const Image(
                                //   image: AssetImage("assets/icons/shortly.png"),
                                // ),
                                // const Image(
                                //   image: AssetImage("assets/images/main.png"),
                                // ),
                                Center(
                                  child: SizedBox(
                                    width: size.width / 2 + 40,
                                    child: Column(
                                      children: [
                                        Text(
                                          ShortlyTexts.letsGetStarted,
                                          textAlign: TextAlign.center,
                                          style: kLargeTitleStyle(kBlack),
                                        ),
                                        const SizedBox(
                                            height: defaultSizeBoxPadding),
                                        Text(
                                          ShortlyTexts.pasteLink,
                                          textAlign: TextAlign.center,
                                          style: kTitleStyle(kBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          state.isAddButtonPressed
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: kSecondaryColor,
                                  ),
                                )
                              : Center(
                                  child: Container(),
                                ),
                        ],
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: padding.top + 20),
                            Text(
                              ShortlyTexts.yourLinkHistory,
                              style: kTitleStyle(kBlack),
                            ),
                            Text(state.shortLinks.first.fullShortLink),
                            for (int i = 0; i < state.shortLinks.length; i++)
                              Column(
                                children: [
                                  SizedBox(height: 2 * defaultSizeBoxPadding),
                                  _ShortLinkContainer(
                                    shortLink: state.shortLinks[i],
                                    fullLink: state.shortLinks[i].fullShortLink,
                                    addEvent: _addEvent,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
              ),
              Container(
                width: size.width,
                color: kSecondaryColor,
                height: size.width / 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: size.width - 5 * horizontalPadding,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: kBackGroundColor,
                      ),
                      child: TextFormField(
                        controller: homeBloc.editingController,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          _addEvent(OnUrlTextFormFieldChanged(value));
                        },
                        cursorColor: kPrimaryColor,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: ShortlyTexts.shortenAlinkHere,
                          hintStyle: kHintTextStyle(kGrey),
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultSizeBoxPadding),
                    Container(
                      width: size.width - 5 * horizontalPadding,
                      child: DefaultButton(
                        onPressed: state.url.isNotEmpty
                            ? () {
                                _addEvent(OnShortenItButtonPressed(state.url));
                              }
                            : null,
                        text: ShortlyTexts.shortenIt,
                        color: state.url.isNotEmpty
                            ? kPrimaryColor
                            : kDisabledButtonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _ShortLinkContainer extends StatelessWidget {
  final ShortLink shortLink;
  final String fullLink;
  final Function(HomeEvent event) addEvent;

  _ShortLinkContainer({
    required this.shortLink,
    required this.fullLink,
    required this.addEvent,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width - 2 * horizontalPadding,
      height: size.width / 2 - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              top: horizontalPadding,
              left: horizontalPadding,
              right: horizontalPadding,
            ),
            child: Row(
              children: [
                Container(
                  width: size.width - 6 * horizontalPadding,
                  child: Text(
                    fullLink,
                    style: kContentStyleBold(kBlack),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    addEvent(RemoveShortLinkFromHistory(shortLink.id));
                  },
                  child: Icon(
                    Icons.delete,
                    color: kBlack,
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: kBlack,
          ),
          Container(
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
            ),
            width: size.width - 6 * horizontalPadding,
            child: Text(
              shortLink.fullShortLink,
              style: kContentStyleBold(kPrimaryColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 2 * defaultSizeBoxPadding),
          Container(
            padding: EdgeInsets.only(
              left: horizontalPadding,
              right: horizontalPadding,
            ),
            height: 40,
            child: DefaultButton(
              onPressed: () async {
                addEvent(CopyItemToClipboard(shortLink));

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Copied to clipboard'),
                ));
              },
              text:
                  shortLink.isCopied ? ShortlyTexts.copied : ShortlyTexts.copy,
              color: shortLink.isCopied ? kSecondaryColor : kPrimaryColor,
            ),
          )
        ],
      ),
    );
  }
}
