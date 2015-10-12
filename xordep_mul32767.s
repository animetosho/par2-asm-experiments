# disassembled from XOR algo's JIT for multiplying by 32767
# slightly modified for readability etc
# algorithm doesn't use LH tables, so that arg is ignored
# NOTE: size must be a multiple of 256

.text
.intel_syntax noprefix
.globl rs_process_xordep_mul32767
rs_process_xordep_mul32767:
#	rs_process_xordep_mul32767(void* dst (%rdi), const void* src (%rsi), size_t size (%rdx), const u16* LH (%rcx));

# save xmm6-15 for Windows' sake, not necessary otherwise
 push        rbp  
 mov         rbp,rsp  
 mov         rax,rsp  
 and         rax,0xF  
 sub         rbp,rax  
 movaps      xmmword ptr [rbp-0x10],xmm6  
 movaps      xmmword ptr [rbp-0x20],xmm7  
 movaps      xmmword ptr [rbp-0x30],xmm8  
 movaps      xmmword ptr [rbp-0x40],xmm9  
 movaps      xmmword ptr [rbp-0x50],xmm10  
 movaps      xmmword ptr [rbp-0x60],xmm11  
 movaps      xmmword ptr [rbp-0x70],xmm12  
 movaps      xmmword ptr [rbp-0x80],xmm13  
 movaps      xmmword ptr [rbp-0x90],xmm14  
 movaps      xmmword ptr [rbp-0xA0],xmm15  

 mov         rax,rsi       #src  
 lea         rcx,[rdi+rdx] #dest-end  
 mov         rdx,rdi       #dest  

.align 16
.loop:
# pre-load inputs 3-15 into registers (can't fit all 16 inputs)
 movaps      xmm3,xmmword ptr [rax+0x30]  
 movaps      xmm4,xmmword ptr [rax+0x40]  
 movaps      xmm5,xmmword ptr [rax+0x50]  
 movaps      xmm6,xmmword ptr [rax+0x60]  
 movaps      xmm7,xmmword ptr [rax+0x70]  
 movaps      xmm8,xmmword ptr [rax+0x80]  
 movaps      xmm9,xmmword ptr [rax+0x90]  
 movaps      xmm10,xmmword ptr [rax+0xA0]  
 movaps      xmm11,xmmword ptr [rax+0xB0]  
 movaps      xmm12,xmmword ptr [rax+0xC0]  
 movaps      xmm13,xmmword ptr [rax+0xD0]  
 movaps      xmm14,xmmword ptr [rax+0xE0]  
 movaps      xmm15,xmmword ptr [rax+0xF0]  

# process 256 bytes; algorithm does it in 32 byte 'sub-blocks'
 movaps      xmm0,xmmword ptr [rdx] 
 movdqa      xmm1,xmmword ptr [rdx+0x10]
 movaps      xmm2,xmmword ptr [rax]  
 xorps       xmm2,xmmword ptr [rax+0x10]  
 pxor        xmm1,xmmword ptr [rax+0x20]  
 xorps       xmm0,xmm3  
 xorps       xmm2,xmm4  
 xorps       xmm2,xmm5  
 xorps       xmm2,xmm6  
 pxor        xmm1,xmm7  
 xorps       xmm0,xmm11  
 xorps       xmm2,xmm12  
 xorps       xmm2,xmm13  
 xorps       xmm2,xmm14  
 pxor        xmm1,xmm15  
 xorps       xmm0,xmm2  
 pxor        xmm1,xmm2  
 movaps      xmmword ptr [rdx],xmm0  
 movdqa      xmmword ptr [rdx+0x10],xmm1  
 
 movaps      xmm0,xmmword ptr [rdx+0x20] 
 movdqa      xmm1,xmmword ptr [rdx+0x30]
 movaps      xmm2,xmmword ptr [rax]  
 xorps       xmm2,xmmword ptr [rax+0x10]  
 xorps       xmm2,xmmword ptr [rax+0x20]  
 xorps       xmm2,xmm3  
 pxor        xmm1,xmm4  
 xorps       xmm0,xmm5  
 xorps       xmm2,xmm6  
 xorps       xmm2,xmm7  
 xorps       xmm2,xmm8  
 pxor        xmm1,xmm9  
 xorps       xmm0,xmm13  
 xorps       xmm2,xmm14  
 xorps       xmm2,xmm15  
 xorps       xmm0,xmm2  
 pxor        xmm1,xmm2  
 movaps      xmmword ptr [rdx+0x20],xmm0  
 movdqa      xmmword ptr [rdx+0x30],xmm1  
 
 movaps      xmm0,xmmword ptr [rdx+0x40] 
 movdqa      xmm1,xmmword ptr [rdx+0x50]
 pxor        xmm1,xmmword ptr [rax]  
 xorps       xmm0,xmmword ptr [rax+0x20]  
 pxor        xmm1,xmm3  
 xorps       xmm0,xmm6  
 movaps      xmm2,xmm7  
 xorps       xmm2,xmm8  
 xorps       xmm2,xmm9  
 xorps       xmm2,xmm10  
 xorps       xmm2,xmm11  
 xorps       xmm2,xmm12  
 xorps       xmm2,xmm13  
 xorps       xmm2,xmm14  
 xorps       xmm2,xmm15  
 xorps       xmm0,xmm2  
 pxor        xmm1,xmm2  
 movaps      xmmword ptr [rdx+0x40],xmm0  
 movdqa      xmmword ptr [rdx+0x50],xmm1  
 
 movaps      xmm0,xmmword ptr [rdx+0x60] 
 movdqa      xmm1,xmmword ptr [rdx+0x70]
 pxor        xmm1,xmmword ptr [rax]  
 xorps       xmm0,xmmword ptr [rax+0x10]  
 pxor        xmm1,xmmword ptr [rax+0x20]  
 xorps       xmm0,xmm4  
 pxor        xmm1,xmm5  
 xorps       xmm0,xmm8  
 movaps      xmm2,xmm9  
 xorps       xmm2,xmm10  
 xorps       xmm2,xmm11  
 xorps       xmm2,xmm12  
 xorps       xmm2,xmm13  
 xorps       xmm2,xmm14  
 xorps       xmm2,xmm15  
 xorps       xmm0,xmm2  
 pxor        xmm1,xmm2  
 movaps      xmmword ptr [rdx+0x60],xmm0  
 movdqa      xmmword ptr [rdx+0x70],xmm1  
 
 movaps      xmm0,xmmword ptr [rdx+0x80] 
 movdqa      xmm1,xmmword ptr [rdx+0x90]
 xorps       xmm0,xmmword ptr [rax]  
 movaps      xmm2,xmmword ptr [rax+0x10]  
 pxor        xmm1,xmmword ptr [rax+0x20]  
 xorps       xmm0,xmm3  
 pxor        xmm1,xmm4  
 xorps       xmm0,xmm6  
 pxor        xmm1,xmm7  
 xorps       xmm0,xmm10  
 xorps       xmm2,xmm11  
 xorps       xmm2,xmm12  
 xorps       xmm2,xmm13  
 xorps       xmm2,xmm14  
 xorps       xmm2,xmm15  
 xorps       xmm0,xmm2  
 pxor        xmm1,xmm2  
 movaps      xmmword ptr [rdx+0x80],xmm0  
 movdqa      xmmword ptr [rdx+0x90],xmm1  
 
 movaps      xmm0,xmmword ptr [rdx+0xA0] 
 movdqa      xmm1,xmmword ptr [rdx+0xB0]
 xorps       xmm0,xmmword ptr [rax]  
 pxor        xmm1,xmmword ptr [rax+0x10]  
 xorps       xmm0,xmmword ptr [rax+0x20]  
 movaps      xmm2,xmm3  
 pxor        xmm1,xmm4  
 xorps       xmm0,xmm5  
 pxor        xmm1,xmm6  
 xorps       xmm0,xmm8  
 pxor        xmm1,xmm9  
 xorps       xmm0,xmm12  
 xorps       xmm2,xmm13  
 xorps       xmm2,xmm14  
 xorps       xmm2,xmm15  
 xorps       xmm0,xmm2  
 pxor        xmm1,xmm2  
 movaps      xmmword ptr [rdx+0xA0],xmm0  
 movdqa      xmmword ptr [rdx+0xB0],xmm1  
 
 movaps      xmm0,xmmword ptr [rdx+0xC0] 
 movdqa      xmm1,xmmword ptr [rdx+0xD0]
 movaps      xmm2,xmmword ptr [rax]  
 xorps       xmm0,xmmword ptr [rax+0x20]  
 xorps       xmm2,xmm4  
 xorps       xmm0,xmm5  
 xorps       xmm0,xmm7  
 pxor        xmm1,xmm8  
 xorps       xmm0,xmm10  
 pxor        xmm1,xmm12  
 pxor        xmm1,xmm13  
 xorps       xmm2,xmm14  
 xorps       xmm2,xmm15  
 xorps       xmm0,xmm2  
 pxor        xmm1,xmm2  
 movaps      xmmword ptr [rdx+0xC0],xmm0  
 movdqa      xmmword ptr [rdx+0xD0],xmm1  
 
 movaps      xmm0,xmmword ptr [rdx+0xE0] 
 movdqa      xmm1,xmmword ptr [rdx+0xF0]
 movaps      xmm2,xmmword ptr [rax]  
 xorps       xmm0,xmmword ptr [rax+0x10]  
 pxor        xmm1,xmmword ptr [rax+0x20]  
 pxor        xmm1,xmm3  
 pxor        xmm1,xmm4  
 xorps       xmm2,xmm5  
 xorps       xmm0,xmm9  
 pxor        xmm1,xmm10  
 pxor        xmm1,xmm11  
 pxor        xmm1,xmm12  
 xorps       xmm2,xmm13  
 xorps       xmm0,xmm14  
 xorps       xmm2,xmm15  
 xorps       xmm0,xmm2  
 pxor        xmm1,xmm2  
 movaps      xmmword ptr [rdx+0xE0],xmm0  
 movdqa      xmmword ptr [rdx+0xF0],xmm1  
#end of main processing

 add         rax,0x100  
 add         rdx,0x100  
 cmp         rdx,rcx  
 jl          .loop  

# restore xmm6-15  
 movaps      xmm6,xmmword ptr [rbp-0x10]  
 movaps      xmm7,xmmword ptr [rbp-0x20]  
 movaps      xmm8,xmmword ptr [rbp-0x30]  
 movaps      xmm9,xmmword ptr [rbp-0x40]  
 movaps      xmm10,xmmword ptr [rbp-0x50]  
 movaps      xmm11,xmmword ptr [rbp-0x60]  
 movaps      xmm12,xmmword ptr [rbp-0x70]  
 movaps      xmm13,xmmword ptr [rbp-0x80]  
 movaps      xmm14,xmmword ptr [rbp-0x90]  
 movaps      xmm15,xmmword ptr [rbp-0xA0]  
 pop         rbp  
 ret  
