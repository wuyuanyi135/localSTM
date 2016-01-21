/* cortex-m3 */
.syntax unified

.section INTERRUPT_TABLE, "x"
.global _Reset

_Reset:
  B Reset_Handler
  B . /* Undefined */
  B . /* SWI */
  B . /* Prefetch Abort */
  B . /* Data Abort */
  B . /* reserved */
  B . /* IRQ */
  B . /* FIQ */

Reset_Handler:
  LDR sp, =stack_top
  BL main
  B .
