import 'package:intl/intl.dart';

class Cartao {
  int? id;
  String descricao = "";
  DateTime? vencimento;
  String codSeguranca = "";
  String numeroCartao = "";

  Cartao.novo();
  Cartao(this.descricao, this.vencimento, this.codSeguranca, this.numeroCartao,
      {this.id});

  String retornarVencimentoFormatado() {
    if (vencimento != null) {
      return DateFormat("MM/yy").format(vencimento!).toString();
    } else {
      return DateFormat("MM/yy").format(DateTime.now()).toString();
    }
  }
}
