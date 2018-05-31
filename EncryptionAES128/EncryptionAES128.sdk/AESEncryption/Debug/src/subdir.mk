################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 

C_SRCS += \
../src/Encryption.c \
../src/md5.c \
../src/platform.c 

OBJS += \
./src/Encryption.o \
./src/md5.o \
./src/platform.o 

C_DEPS += \
./src/Encryption.d \
./src/md5.d \
./src/platform.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MicroBlaze gcc compiler'
	mb-gcc -l -Wall -O0 -g3 -IC:\OpenSSL-Win64\include -c -fmessage-length=0 -MT"$@" -I../../AESEncryption_bsp/microblaze_0/include -mlittle-endian -mcpu=v10.0 -mxl-soft-mul -Wl,--no-relax -ffunction-sections -fdata-sections -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


