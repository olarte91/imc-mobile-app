import 'package:flutter/material.dart';
import 'package:imc_calculator/core/app_colors.dart';
import 'package:imc_calculator/core/text_styles.dart';

class ImcResultScreen extends StatelessWidget {
  final double height;
  final int weight;
  const ImcResultScreen({
    super.key,
    required this.height,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    double fixedHeight = height / 100;
    double imcResult = weight / (fixedHeight * fixedHeight);
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: toolbarResult(),
      body: bodyResult(imcResult, context),
    );
  }

  Padding bodyResult(double result, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tu resultado",
            style: TextStyle(
              fontSize: 38,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 32),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      getStatusByImc(result),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: getColorByImc(result),
                      ),
                    ),
                    Text(
                      result.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 76,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getDescriptionOfImc(result),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all(AppColors.secondary),
              ),
              child: Text("Finalizar", style: TextStyles.bodyText),
            ),
          ),
        ],
      ),
    );
  }

  AppBar toolbarResult() {
    return AppBar(
      title: Text("Resultado"),
      backgroundColor: AppColors.secondary,
      foregroundColor: Colors.white,
    );
  }

  Color getColorByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => Colors.blue, //Imc Bajo
      < 24.9 => Colors.green, //Imc Normal
      < 29.99 => Colors.orange, //Sobrepeso
      _ => Colors.red, //Obseidad
    };
  }

  String getStatusByImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => "Bajo", //Imc Bajo
      < 24.9 => "Normal", //Imc Normal
      < 29.99 => "Sobrepeso", //Sobrepeso
      _ => "Obesidad", //Obseidad
    };
  }

  String getDescriptionOfImc(double imcResult) {
    return switch (imcResult) {
      < 18.5 => "Tu peso está por debajo de lo recomendado", //Imc Bajo
      < 24.9 => "Tu peso está en el rango saludable", //Imc Normal
      < 29.99 => "Tienes sobrepeso, cuida tu alimentación", //Sobrepeso
      _ => "Tienes obesidad, consulta con un especialista", //Obseidad
    };
  }
}
