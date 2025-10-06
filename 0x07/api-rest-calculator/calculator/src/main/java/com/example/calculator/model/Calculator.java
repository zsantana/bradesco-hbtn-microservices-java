package com.example.calculator.model;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class Calculator {

    public Double sum(Double number1, Double number2) {
        if (number1 == null || number2 == null) {
            throw new NullPointerException("Número 1 e número 2 são obrigatórios.");
        }
        return number1 + number2;
    }

    public Double sub(Double number1, Double number2) {
        if (number1 == null || number2 == null) {
            throw new NullPointerException("Número 1 e número 2 são obrigatórios.");
        }
        return number1 - number2;
    }

    public Double divide(Double number1, Double number2) {
        if (number1 == null || number2 == null) {
            throw new NullPointerException("Número 1 e número 2 são obrigatórios.");
        }
        if (number2 == 0.0) {
            throw new ArithmeticException("Divisão por zero não é permitido.");
        }
        return number1 / number2;
    }

    public Integer factorial(Integer factorial) {
        if (factorial == null) {
            throw new NullPointerException("Número é obrigatório.");
        }
        if (factorial < 0) {
            throw new IllegalArgumentException("Não existe fatorial de número negativo.");
        }
        int f = 1;
        for (int i = 2; i <= factorial; i++) {
            f *= i;
        }
        return f;
    }

    public Integer integerToBinary(Integer integer) {
        if (integer == null) {
            throw new NullPointerException("Número é obrigatório.");
        }
        return Integer.parseInt(Integer.toBinaryString(integer));
    }

    public String integerToHexadecimal(Integer integer) {
        if (integer == null) {
            throw new NullPointerException("Número é obrigatório.");
        }
        return Integer.toHexString(integer).toUpperCase();
    }

    public int calculeDayBetweenDate(LocalDate date1, LocalDate date2) {
        if (date1 == null || date2 == null) {
            throw new NullPointerException("As datas são obrigatórias.");
        }
        return (int)Math.abs(ChronoUnit.DAYS.between(date1, date2));
    }
}
