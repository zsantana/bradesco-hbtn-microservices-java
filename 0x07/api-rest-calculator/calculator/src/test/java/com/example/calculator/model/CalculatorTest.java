package com.example.calculator.model;

import org.junit.jupiter.api.Test;
import java.time.LocalDate;
import static org.junit.jupiter.api.Assertions.*;

public class CalculatorTest {

    Calculator calculator = new Calculator();

    @Test
    void sumTest() {
        assertEquals(3.0, calculator.sum(1.0, 2.0));
    }

    @Test
    public void numbersNullSumTest() {
        assertThrows(NullPointerException.class, () -> calculator.sum(null, null));
    }

    @Test
    void subTest() {
        assertEquals(-1.0, calculator.sub(1.0, 2.0));
    }

    @Test
    void divideTest() {
        assertEquals(2.0, calculator.divide(4.0, 2.0));
    }

    @Test
    public void divisionByZeroTest() {
        assertThrows(ArithmeticException.class, () -> calculator.divide(10.0, 0.0));
    }

    @Test
    void factorialTest() {
        assertEquals(120, calculator.factorial(5));
        assertEquals(1, calculator.factorial(0));
    }

    @Test
    void integerToBinaryTest() {
        assertEquals(1, calculator.integerToBinary(1));
        assertEquals(101, calculator.integerToBinary(5));
        assertEquals(10100, calculator.integerToBinary(20));
    }

    @Test
    void integerToHexadecimalTest() {
        assertEquals("1", calculator.integerToHexadecimal(1));
        assertEquals("5", calculator.integerToHexadecimal(5));
        assertEquals("AA", calculator.integerToHexadecimal(170));
    }

    @Test
    void calculeDayBetweenDateTest() {
        LocalDate d1 = LocalDate.of(2020, 3, 15);
        LocalDate d2 = LocalDate.of(2020, 3, 29);
        assertEquals(14, calculator.calculeDayBetweenDate(d1, d2));
    }
}
