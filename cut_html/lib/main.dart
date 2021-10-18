import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool check = true;

  bool check1 = true;

  bool check2 = true;

  bool check3 = true;

  bool check4 = true;

  int count = 0;

  int count1 = 0;

  int count2 = 0;

  int count3 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
        centerTitle: true,
        backgroundColor: Color(0XFF22A45D),
        actions: [
          Icon(Icons.shopping_basket),
          Icon(Icons.list),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(22, 29, 22, 20),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: check,
                  onChanged: (bool value) {
                    setState(() {
                      check = value;
                    });
                  },
                ),
                SizedBox(width: 26),
                Image.asset('lib/assets/beat.png'),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Thịt lợn ba chỉ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Giao trong 24h',
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ),
                    Container(
                      child: Text(
                        '150.000 đ',
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ),
                    Row(
                      children: [
                        ButtonTheme(
                          minWidth: 30,
                          height: 25,
                          child: FlatButton(
                            color: Colors.grey[200],
                            onPressed: count == 0
                                ? null
                                : () {
                                    setState(() {
                                      count -= 1;
                                    });
                                  },
                            child: Text('-'),
                          ),
                        ),
                        Text(
                          '$count',
                          style: TextStyle(),
                        ),
                        ButtonTheme(
                          minWidth: 30,
                          height: 25,
                          child: FlatButton(
                            color: Colors.grey[200],
                            onPressed: () {
                              setState(() {
                                count += 1;
                              });
                            },
                            child: Text('+'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey),
            Row(
              children: [
                Checkbox(
                  value: check1,
                  onChanged: (bool value) {
                    setState(() {
                      check1 = value;
                    });
                  },
                ),
                SizedBox(width: 26),
                Image.asset('lib/assets/beat.png'),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Thịt lợn ba chỉ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Giao trong 24h',
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ),
                    Container(
                      child: Text(
                        '150.000 đ',
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ),
                    Row(
                      children: [
                        ButtonTheme(
                          minWidth: 30,
                          height: 25,
                          child: FlatButton(
                            color: Colors.grey[200],
                            onPressed: count1 == 0
                                ? null
                                : () {
                                    setState(() {
                                      count1 -= 1;
                                    });
                                  },
                            child: Text('-'),
                          ),
                        ),
                        Text(
                          '$count1',
                          style: TextStyle(),
                        ),
                        ButtonTheme(
                          minWidth: 30,
                          height: 25,
                          child: FlatButton(
                            color: Colors.grey[200],
                            onPressed: () {
                              setState(() {
                                count1 += 1;
                              });
                            },
                            child: Text('+'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey),
            Row(
              children: [
                Checkbox(
                  value: check2,
                  onChanged: (bool value) {
                    setState(() {
                      check2 = value;
                    });
                  },
                ),
                SizedBox(width: 26),
                Image.asset('lib/assets/beat.png'),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Thịt lợn ba chỉ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Giao trong 24h',
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ),
                    Container(
                      child: Text(
                        '150.000 đ',
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ),
                    Row(
                      children: [
                        ButtonTheme(
                          minWidth: 30,
                          height: 25,
                          child: FlatButton(
                            color: Colors.grey[200],
                            onPressed: count2 == 0
                                ? null
                                : () {
                                    setState(() {
                                      count2 -= 1;
                                    });
                                  },
                            child: Text('-'),
                          ),
                        ),
                        Text(
                          '$count2',
                          style: TextStyle(),
                        ),
                        ButtonTheme(
                          minWidth: 30,
                          height: 25,
                          child: FlatButton(
                            color: Colors.grey[200],
                            onPressed: () {
                              setState(() {
                                count2 += 1;
                              });
                            },
                            child: Text('+'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey),
            Row(
              children: [
                Checkbox(
                  value: check3,
                  onChanged: (bool value) {
                    setState(() {
                      check3 = value;
                    });
                  },
                ),
                SizedBox(width: 26),
                Image.asset('lib/assets/beat.png'),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Thịt lợn ba chỉ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Giao trong 24h',
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ),
                    Container(
                      child: Text(
                        '150.000 đ',
                        style: TextStyle(fontSize: 14, color: Colors.red),
                      ),
                    ),
                    Row(
                      children: [
                        ButtonTheme(
                          minWidth: 30,
                          height: 25,
                          child: FlatButton(
                            color: Colors.grey[200],
                            onPressed: count3 == 0
                                ? null
                                : () {
                                    setState(() {
                                      count3 -= 1;
                                    });
                                  },
                            child: Text('-'),
                          ),
                        ),
                        Text(
                          '$count3',
                          style: TextStyle(),
                        ),
                        ButtonTheme(
                          minWidth: 30,
                          height: 25,
                          child: FlatButton(
                            color: Colors.grey[200],
                            onPressed: () {
                              setState(() {
                                count3 += 1;
                              });
                            },
                            child: Text('+'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Thông tin nhận hàng',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Hoàng Đức Tuấn',
                        style: TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Số 9 Nguyên Hồng, Ba Đình, Hà Nội',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      child: Text(
                        '0912.345.678',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  textColor: Colors.green,
                  onPressed: () {},
                  child: Text('Sửa'),
                )
              ],
            ),
            Divider(color: Colors.grey),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mã Khuyến mãi',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    ButtonTheme(
                      minWidth: 210,
                      height: 40,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.grey[200],
                        onPressed: () {},
                        child: Text('Nhập mã khuyến mãi'),
                      ),
                    ),
                    SizedBox(width: 10),
                    ButtonTheme(
                      minWidth: 140,
                      height: 40,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Colors.green[600],
                        textColor: Colors.white,
                        onPressed: () {},
                        child: Text('Áp dụng'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tạm Tính', style: TextStyle(fontSize: 16)),
                    Text('Phí vận chuyển', style: TextStyle(fontSize: 16)),
                    Text('Khuyến mại', style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(width: 180),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '135.333đ',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    Text(
                      '5.333đ',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    Text(
                      '15.000đ',
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    )
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey),
            Row(
              children: [
                Column(
                  children: [
                    Checkbox(
                      value: check4,
                      onChanged: (bool value) {
                        setState(() {
                          check4 = value;
                        });
                      },
                    ),
                    Icon(Icons.monetization_on)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chọn tất cả',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text('Tổng tiền:'),
                        Text(
                          '130.000đ',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 30),
                ButtonTheme(
                  minWidth: 130,
                  height: 60,
                  child: FlatButton(
                    color: Color(0XFFEF6B20),
                    textColor: Colors.white,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Đặt ngay',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
