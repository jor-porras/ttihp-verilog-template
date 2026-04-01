# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start Fibonacci test")

    # Clock: 100 kHz (10 us period)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Inicialización
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0

    # Reset activo en bajo
    dut._log.info("Applying reset")
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 2)
    dut.rst_n.value = 1

    dut._log.info("Checking Fibonacci sequence")

    # Secuencia esperada después del reset
    expected_values = [1, 1, 2, 3, 5, 8, 13, 21]

    for expected in expected_values:
        await ClockCycles(dut.clk, 1)
        actual = int(dut.uo_out.value)
        dut._log.info(f"Expected: {expected}, Got: {actual}")
        assert actual == expected, f"Expected {expected}, got {actual}"
