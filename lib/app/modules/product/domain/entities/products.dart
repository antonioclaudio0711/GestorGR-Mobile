class Products {
  Products({
    this.productId,
    this.codEan,
    this.reference,
    this.description,
    this.unit,
    this.costValue,
    this.sellingValue,
    this.typeId,
    this.type,
    this.brandId,
    this.brand,
    this.amount,
    this.groupId,
    this.group,
    this.subgroupId,
    this.subgroup,
  });

  final int? productId;
  final String? codEan;
  final String? reference;
  final String? description;
  final String? unit;
  final double? costValue;
  final double? sellingValue;
  final int? typeId;
  final String? type;
  final int? brandId;
  final String? brand;
  final double? amount;
  final int? groupId;
  final String? group;
  final int? subgroupId;
  final String? subgroup;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        productId: json["PRODUTO_ID"],
        codEan: json["COD_EAN"],
        reference: json["REFERENCIA"],
        description: json["DESCRICAO"],
        unit: json["UNIDADE"],
        costValue: json["VL_CUSTO"].toDouble(),
        sellingValue: json["VL_VENDA"].toDouble(),
        typeId: json["TIPO_ID"] ?? 0,
        type: json["TIPO"],
        brandId: json["MARCA_ID"],
        brand: json["MARCA"],
        amount: json["EST_SALDO"].toDouble(),
        groupId: json["GRUPO_ID"],
        group: json["GRUPO"],
        subgroupId: json["SUBGRUPO_ID"],
        subgroup: json["SUBGRUPO"],
      );

  Map<String, dynamic> productsToJson() => {
        "PRODUTO_ID": productId,
        "COD_EAN": codEan,
        "REFERENCIA": reference,
        "DESCRICAO": description,
        "UNIDADE": unit,
        "VL_CUSTO": costValue,
        "VL_VENDA": sellingValue,
        "TIPO_ID": typeId,
        "TIPO": type,
        "MARCA_ID": brandId,
        "MARCA": brand,
        "EST_SALDO": amount,
        "GRUPO_ID": groupId,
        "GRUPO": group,
        "SUBGRUPO_ID": subgroupId,
        "SUBGRUPO": subgroup,
      };
}
