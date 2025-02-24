sealed class Failure {
  final String mensaje;

  Failure({required this.mensaje});
}

class FallaDesconocida extends Failure {
  FallaDesconocida() : super(mensaje: 'Error desconocido');
}

class FallaParametros extends Failure {
  FallaParametros() : super(mensaje: 'Error el los parametros enviados');
}

class FallaServidor extends Failure {
  FallaServidor() : super(mensaje: 'Error en el servidor');
}

class FallaDeAutorizacion extends Failure {
  FallaDeAutorizacion()
      : super(mensaje: 'Error en los parametros de autorizacion');
}

class FallaEnLaConeccion extends Failure {
  FallaEnLaConeccion() : super(mensaje: 'Usted no tiene internet');
}

class FallaNoEncontrado extends Failure {
  FallaNoEncontrado() : super(mensaje: 'No se encontro la data');
}
