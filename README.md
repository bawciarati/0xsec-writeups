# About Me

ผมเป็นคนหนึ่งที่ชอบแกะของ — โดยเฉพาะของที่ไม่มีซอร์ส ให้โค้ด, โปรโตคอล, ไบนารี และไฟล์แปลก ๆ เล่าสิ่งที่มันทำจริง มากกว่าสิ่งที่ README บอกว่ามันทำ

เวลาส่วนใหญ่อยู่กับ **malware analysis**, **reverse engineering** และ **Windows internals** บางทีก็เล่น **CTF** และไล่บั๊กในเว็บแอป
ถ้ามันถูกสร้างจากโค้ด ผมอยากรู้ว่ามันพังได้ยังไง

หน้านี้คือสมุดจดของผม — ทุกโพสต์เขียนจากการวิเคราะห์จริงในเครื่องตัวเอง ไม่ใช่การสรุปจากบทความคนอื่น ถ้าผมไม่รู้ ผมจะเขียนว่าไม่รู้

{% hint style="info" %}
**Contact:** `YOUR_EMAIL` · GitHub [`0xYOURHANDLE`](https://github.com/0xYOURHANDLE) · X [`@0xYOURHANDLE`](https://x.com/0xYOURHANDLE)
{% endhint %}

## Projects

### DBDAxera — loader teardown

Static teardown ของ loader ที่อัปเดตตัวเองผ่าน HTTPS โดยไม่ตรวจ hash หรือลายเซ็นเลยแม้แต่ไบต์เดียว และรันผลลัพธ์ด้วยสิทธิ์ Administrator — [อ่านโพสต์เต็ม](malware-analysis/2026-11-13-dbdaxera-updater.md)

### YARA rules

กติกาตรวจจับที่เขียนจากไบต์จริงของตัวอย่าง ไม่ใช่จาก plaintext ที่เดาเอา — ดูใน [Detections](malware-analysis/2026-11-13-dbdaxera-updater.md#detection) ของแต่ละโพสต์

## What you'll find here

| Section | เนื้อหา |
| --- | --- |
| Malware Analysis | ถอดโครงสร้าง loader / stealer / RAT, string obfuscation, C2, persistence, และกติกาตรวจจับ |
| Windows & AD | internals, privilege escalation, COM, UAC, LOLBins |
| CTF Writeups | วิธีคิด ไม่ใช่แค่ flag |
| Blogs | note ทั่วไปที่ไม่อยู่ในหมวดข้างบน |

## Ground rules

- ทุกตัวอย่างวิเคราะห์แบบ **static** ก่อนเสมอ ถ้าต้องรัน จะรันใน VM ที่แยกจากเน็ตเวิร์กจริง
- แฮช, แอดเดรส, และออฟเซ็ตที่ลงในโพสต์คือค่าที่ตรวจแล้ว ไม่ใช่ค่าที่เดาจาก knowledge cutoff
- ไม่มีโพสต์ไหนบอกให้คุณรันอะไรบนเครื่องจริง — ตัวอย่างเป็นอันตราย

{% hint style="warning" %}
หน้านี้อยู่ในระหว่างเริ่มต้น: บางลิงก์/ชื่อยังเป็น placeholder (`YOURNAME`, `0xYOURHANDLE`) รอแทนที่
{% endhint %}
