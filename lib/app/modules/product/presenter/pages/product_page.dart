import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobi_gr/app/modules/product/domain/entities/products.dart';
import 'package:mobi_gr/app/modules/product/external/datasources/products_api.dart';
import 'package:mobi_gr/app/modules/product/presenter/widgets/product_field.dart';
import 'package:mobi_gr/app/modules/product/presenter/widgets/product_list_text_item.dart';
import 'package:mobi_gr/utils/widgets/custom_dialog.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Products> productsList = [];
  bool loading = true;
  late String key;
  late String barCode;
  late String value;
  final TextEditingController searchValue = TextEditingController();

  @override
  void initState() {
    ProductsApi.getProducts(key: '', searchElement: '1').then(
      (productsList) {
        setState(() {
          productsList = productsList;
          loading = false;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<String> readCode() async {
    barCode = await FlutterBarcodeScanner.scanBarcode(
      '#ff666',
      'Cancelar',
      true,
      ScanMode.BARCODE,
    );

    if (barCode == '-1') {
      return value = '';
    } else {
      return value = barCode;
    }
  }

  Future<void> onRefresh({String value = ''}) async {
    List<Products> searchResponse =
        await ProductsApi.getProducts(key: value, searchElement: 1);

    setState(
      () {
        productsList = searchResponse;
        loading = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: loading
            ? const Text('Carregando...')
            : const Text('Lista de produtos'),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
              child: Column(
                children: [
                  ProductField(
                    searchProductController: searchValue,
                    overscanOnPressed: () async {
                      searchValue.text = await readCode();
                      loading = true;
                      setState(() {});

                      List<Products> searchResponse =
                          await ProductsApi.getProducts(
                        key: searchValue.text,
                        searchElement: 1,
                      );

                      setState(() {
                        productsList = searchResponse;
                        loading = false;
                      });
                    },
                    clearOnPressed: () {
                      setState(() {
                        onRefresh();
                        searchValue.clear();
                      });
                    },
                    submittedOnPressed: (key) async {
                      setState(() {
                        loading = true;
                      });

                      List<Products> searchResponse =
                          await ProductsApi.getProducts(
                        key: key,
                        searchElement: '1',
                      );

                      setState(
                        () {
                          productsList = searchResponse;
                          loading = false;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: productsList.length,
                      itemBuilder: (context, index) {
                        Products product = productsList[index];
                        return productListItem(product: product);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget productListItem({required Products product}) {
    return ExpansionTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          ProductListTextItem(
            textContent: 'Cód. Referência: ${product.reference}',
          ),
          ProductListTextItem(
            textContent: product.description!,
          ),
          ProductListTextItem(
            textContent: 'Cód. Barras: ${product.codEan}',
          ),
          ProductListTextItem(
            textContent:
                'Valor Venda: R\$ ${product.sellingValue!.toStringAsFixed(2)}',
          ),
        ],
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductListTextItem(
              textContent: 'Unidade: ${product.unit}',
              textColor: Colors.blue,
            ),
            ProductListTextItem(
              textContent: 'Marca: ${product.brand}',
              textColor: Colors.blue,
            ),
            ProductListTextItem(
              textContent: 'Estoque: ${product.amount}',
              textColor: Colors.blue,
            ),
            ProductListTextItem(
              textContent: 'Tipo: ${product.type}',
              textColor: Colors.blue,
            ),
            ProductListTextItem(
              textContent: 'Grupo: ${product.group}',
              textColor: Colors.blue,
            ),
            ProductListTextItem(
              textContent: 'SubGrupo: ${product.subgroup}',
              textColor: Colors.blue,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => productAlertDialog(product: product),
                );
              },
              child: const Text('Editar'),
            )
          ],
        )
      ],
    );
  }

  Widget productAlertDialog({required Products product}) {
    TextEditingController customController = MoneyMaskedTextController(
      decimalSeparator: '.',
      thousandSeparator: '',
    );

    bool validatePattern({required String text}) {
      if (text == '0.00') {
        return false;
      } else {
        return true;
      }
    }

    return AlertDialog(
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('Imprimir'),
            ),
            TextButton(
              onPressed: () {
                if (validatePattern(text: customController.text)) {
                  ProductsApi.updateProducts(
                    productId: product.productId.toString(),
                    sellingValue: customController.text,
                    print: 'S',
                  );
                  Modular.to.pop();

                  Future.delayed(const Duration(seconds: 2)).then(
                    (value) => {
                      onRefresh(value: product.reference!),
                    },
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const CustomDialog(
                        message: 'O valor não pode ser zerado!',
                      );
                    },
                  );
                }
              },
              child: const Text('Salvar e imprimir'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Salvar'),
            ),
          ],
        ),
      ],
      title: Column(
        children: [
          IconButton(
            onPressed: () => Modular.to.pop(),
            icon: const Icon(
              Icons.close,
              color: Colors.blue,
            ),
          ),
          Text(
            'Cód. Ref. : ${product.reference}',
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.description.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: customController,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              labelText: 'Novo valor de venda',
              prefixIcon: IconButton(
                onPressed: () {
                  customController.clear();
                  setState(() {});
                },
                icon: const Icon(Icons.clear),
              ),
              hintText: product.sellingValue.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
