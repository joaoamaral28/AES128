/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xbasic_types.h"
#include "xil_types.h"
#include "xparameters.h"
#include "xil_io.h"
#include "xuartlite.h"
#include <time.h>
#include <unistd.h>

Xuint32 *baseaddr_p = (Xuint32 *)XPAR_AES128_IP_0_S00_AXI_BASEADDR;
XUartLite UartLite;


// MD5 digest function included from
// https://github.com/pod32g/MD5/blob/master/md5.c

void receiveFromUART(char* buffer){

    // Initialize the UartLite driver so that it is ready to use.
	int Status = XUartLite_Initialize(&UartLite, XPAR_UARTLITE_0_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		xil_printf("Failed to initialize XUartLite!\n\r");
		return XST_FAILURE;
	}

	u8 byte;
	int idx = 0;
	//XUartLite_Recv(&UartLite,buffer,1);
	while(1){
		byte = XUartLite_RecvByte(XPAR_AXI_UARTLITE_0_BASEADDR);
		buffer[idx] = byte;
		idx++;
		xil_printf("*");
		if(byte == 0x0d) // carriage return
			break;
	}
	xil_printf("\n\r");
}

int main()
{
    init_platform();
    xil_printf("\n\r AES128 Encryption \n\r");

    // user input password to be used in the algorithm
    char *password;
    xil_printf("Enter password: ");
	receiveFromUART(password);

	uint8_t digest[16];

    size_t len = strlen(password);

    // md5 digest calc from given password
    md5((uint8_t)* password,len, digest);

    //for (int i = 0; i < 16; i++)
	//	xil_printf("%2.2x", digest[i]);
    /*
    xil_printf("\n\rKeyW0 = 0x%x%x%x%x\n\r", digest[12], digest[13], digest[14], digest[15]);
    xil_printf("KeyW1 = 0x%x%x%x%x\n\r", digest[8], digest[9], digest[10], digest[11]);
    xil_printf("KeyW2 = 0x%x%x%x%x\n\r", digest[4], digest[5], digest[6], digest[7]);
    xil_printf("KeyW3 = 0x%x%x%x%x\n\r", digest[0], digest[1], digest[2], digest[3]);
     */

    // convert digest bytes to full word
    uint32_t pw0 = ((digest[12] << 24) | (digest[13] << 16) | (digest[14] << 8) | digest[15]);
    uint32_t pw1 = ((digest[8] << 24) | (digest[9] << 16) | (digest[10] << 8) | digest[11]);
    uint32_t pw2 = ((digest[4] << 24) | (digest[5] << 16) | (digest[6] << 8) | digest[7]);
    uint32_t pw3 = ((digest[0] << 24) | (digest[1] << 16) | (digest[2] << 8) | digest[3]);

    //xil_printf("\n\r W0 = %x", pw0);
    //xil_printf("\n\r W1 = %x", pw1);
    //xil_printf("\n\r W2 = %x", pw2);
    //xil_printf("\n\r W3 = %x \n\r", pw3);

    // Example values
    // input = 3243f6a8885a308d313198a2e0370734
    // key = 2b7e151628aed2a6abf7158809cf4f3c
    // output = 3925841d02dc09fbdc118597196a0b32
    //xil_printf("Input word : 0x3243f6a8 0x885a308d 0x313198a2 0xe0370734 \n\r");
    //xil_printf("Cipher key : 0x2b7e1516 0x28aed2a6 0xabf71588 0x09cf4f3c \n\r");

    // w3 w2 w1 w0
    // slv_reg0 => w0, slv_reg1 => w1, slv_reg2 => w2, sl_reg3 => 3
    // plain text
    Xil_Out32(XPAR_AES128_IP_0_S00_AXI_BASEADDR + 12, 0x3243f6a8);
    Xil_Out32(XPAR_AES128_IP_0_S00_AXI_BASEADDR + 8, 0x885a308d);
    Xil_Out32(XPAR_AES128_IP_0_S00_AXI_BASEADDR + 4, 0x313198a2);
    Xil_Out32(XPAR_AES128_IP_0_S00_AXI_BASEADDR + 0,0xe0370734);
    // write cipher key
    /*
    Xil_Out32(XPAR_AES128_IP_0_S00_AXI_BASEADDR + 28,0x2b7e1516);
    Xil_Out32(XPAR_AES128_IP_0_S00_AXI_BASEADDR + 24,0x28aed2a6);
    Xil_Out32(XPAR_AES128_IP_0_S00_AXI_BASEADDR + 20,0xabf71588);
    Xil_Out32(XPAR_AES128_IP_0_S00_AXI_BASEADDR + 16,0x09cf4f3c);
     */

    Xil_Out32(XPAR_AES128_IP_0_S00_AXI_BASEADDR + 28,pw0);
    Xil_Out32(XPAR_AES128_IP_0_S00_AXI_BASEADDR + 24,pw1);
    Xil_Out32(XPAR_AES128_IP_0_S00_AXI_BASEADDR + 20,pw2);
    Xil_Out32(XPAR_AES128_IP_0_S00_AXI_BASEADDR + 16,pw3);

    xil_printf("Calculating...");
    while( *(baseaddr_p+12)!=0x00000001){
    	for(int i=0; i < 4000000; i++){
    		// wait some time and check if data is available again
    	}
        xil_printf(".");
    }
    xil_printf("\n\r");

    // read algorithm output from slave registers 8-11 of the peripheral
    //xil_printf("cipher W0 : 0x%08x \n\r", *(baseaddr_p+8));
    //xil_printf("cipher W1 : 0x%08x \n\r", *(baseaddr_p+9));
    //xil_printf("cipher W2 : 0x%08x \n\r", *(baseaddr_p+10));
    //xil_printf("cipher W3 : 0x%08x \n\r", *(baseaddr_p+11));

    xil_printf("Ciphertext : %x %x %x %x \n\r", *(baseaddr_p+8), *(baseaddr_p+9), *(baseaddr_p+10), *(baseaddr_p+11) );

    xil_printf("Execution finished! \n\r");

    cleanup_platform();
    return 0;
}

