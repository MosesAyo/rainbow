import '../bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc()..add(PeriodicCheck()),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              flexibleSpace: _userInfo(),
            ),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titleAndBalance(),
                    // // _search(),
                    _marketAPIData(),
                    _allButton(),
                    _savingDropdown(),
                    savingsListItems(),
                    const SizedBox(height: 20),
                    _poolsDropdown(),
                    _poolsListItems(),
                    const SizedBox(height: 10),
                    const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Collectibles',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        )),
                    _showcase(),
                  ]),
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: const Color(0xFF5864ED),
                  onPressed: () {},
                  child: SvgPicture.asset(
                    'assets/svg/swap_icon.svg',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: const Color(0xFF739DF1),
                  onPressed: () {},
                  child: SvgPicture.asset('assets/svg/send_icon.svg'),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ));
  }

  Widget _userInfo() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 40,
                  width: 40,
                  child: SvgPicture.asset(
                    'assets/svg/logo.svg',
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: SvgPicture.asset(
                    'assets/svg/qrscanner.svg',
                  ),
                ),
              ]));
    });
  }

  Widget _titleAndBalance() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Rainbow',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          Text(
            '\$12,00000',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget _marketAPIData() {
    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (previous, current) =>
            previous.marketData != current.marketData,
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: state.isloading
                ? Center(
                    child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child: const LinearProgressIndicator(
                      color: Color(0xFF00B5ED),
                    ),
                  ))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 30);
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    // itemCount: state.marketData.length,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://s2.coinmarketcap.com/static/img/coins/64x64/${state.marketData[index]['id']}.png'))),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${state.marketData[index]['name']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      '${state.marketData[index]['symbol']}',
                                      style: const TextStyle(
                                          color: Color(0xFF828282)),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '\$${state.marketData[index]['quote']['USD']['price'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                state.marketData[index]['quote']['USD']
                                            ['percent_change_1h'] <
                                        0
                                    ? Text(
                                        '${state.marketData[index]['quote']['USD']['percent_change_1h'].toStringAsFixed(2)}%',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      )
                                    : Text(
                                        '${state.marketData[index]['quote']['USD']['percent_change_1h'].toStringAsFixed(2)}%',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
          );
        });
  }

  Widget _allButton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.grey[200],
                  primary: Colors.grey[600]),
              onPressed: () {},
              child: Row(
                children: const [
                  Text('All'),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              )),
          const Text('\$1.08')
        ]));
  }

  Widget _savingDropdown() {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/sunflower.svg',
                      height: 20,
                    ),
                    const Text('Savings',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))
                  ],
                ),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          ],
        ));
  }

  Widget savingsListItems() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300]!,
                    offset: const Offset(0, 3),
                    blurRadius: 10)
              ]),
          // margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://s2.coinmarketcap.com/static/img/coins/64x64/4943.png'))),
                ),
                const SizedBox(width: 10),
                const Text('\$184.939399',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
              ]),
              // a container with gradient background
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 214, 250, 227),
                        Color.fromARGB(255, 247, 255, 205),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: const Text(
                  '4.67% APY',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ));
    });
  }

  Widget _poolsDropdown() {
    return TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          primary: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/fish.svg',
                      height: 20,
                    ),
                    const Text('Pools',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18))
                  ],
                ),
                const Icon(Icons.keyboard_arrow_down_rounded)
              ],
            ),
          ],
        ));
  }

  Widget _poolsListItems() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Row(
                  children: [
                    SizedBox(
                        width: 80,
                        child: Stack(children: [
                          Positioned(
                            left: 30,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://s2.coinmarketcap.com/static/img/coins/64x64/3408.png'))),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://s2.coinmarketcap.com/static/img/coins/64x64/1518.png'))),
                          ),
                        ])),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('MKR-USDC'),
                        Text(
                          '6.786364 UNI-V2',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ],
                )
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('\$3,253.72'),
                  Text('2.81%', style: TextStyle(color: Colors.grey))
                ],
              )
            ],
          ));
    });
  }

  Widget _showcase() {
    return Column(
      children: [
        TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              primary: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/trophy.svg',
                          height: 20,
                        ),
                        const Text('Showcase',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18))
                      ],
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: Colors.grey[200],
                            primary: Colors.grey[600]),
                        onPressed: () {},
                        child: Row(
                          children: const [
                            Text('Share'),
                          ],
                        )),
                  ],
                ),
              ],
            ))
      ],
    );
  }
}
