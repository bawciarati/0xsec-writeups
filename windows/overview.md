# Windows & AD

โพสต์กลุ่มนี้เกี่ยวกับ Windows internals และ Active Directory — สิ่งที่คนส่วนใหญ่ไม่ต้องรู้ แต่คนที่ต้องแยกของดีออกจากของอันตรายจำเป็นต้องรู้

## แผนที่จะเขียน

- COM object ที่เรียกได้โดยไม่ต้อง elevate (และทำไมมันถึงสำคัญ)
- UAC: อะไรที่ auto-elevate ได้จริง อะไรที่แค่ดูเหมือนทำได้
- Token, integrity level, และ privileges ที่ malware อยากได้
- LOLBins ที่ยังใช้งานได้ในปี 2026
- AD: Kerberos, delegation, และ certificate abuse

## กติกา

ทุกโพสต์จะบอกว่า **ทดสอบบนอะไร** (build number, patch level) เพราะพฤติกรรมของ Windows เปลี่ยนตาม build ถ้าผมทดสอบแค่ VM เดียว จะเขียนไว้ให้ชัด
