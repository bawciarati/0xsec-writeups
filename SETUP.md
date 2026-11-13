# SETUP — เอาชุดไฟล์นี้ขึ้น GitBook

คู่มือนี้เป็นของ **คุณ** ไม่ใช่ของคนอ่าน: ไฟล์นี้อยู่ใน repo แต่ไม่ได้ผูกใน `SUMMARY.md` จึงไม่ขึ้นในเมนูเว็บ

สถานะปัจจุบัน: repo เตรียมไว้แล้ว (`git init` + commit แรก) แต่ยัง **ไม่มี remote** — ต้องสร้าง repo GitHub เองก่อน

---

## 0. สิ่งที่ต้องมี

- บัญชี GitHub
- บัญชี GitBook (ฟรีก็พอสำหรับ space เดียว + custom domain)
- `git` ในเครื่อง (มีแล้ว: `C:\Program Files\Git\cmd\git.exe`)

---

## 1. สร้าง repo บน GitHub

1. github.com → **New repository**
2. ชื่อแนะนำ: `0xsec-writeups` (หรืออะไรก็ได้ที่คุณชอบ)
3. **Private หรือ Public ก็ได้** — Git Sync ทำงานได้ทั้งคู่
   - ถ้า Public: ระวังอย่า commit ตัวอย่าง malware ลง repo (ตอนนี้ยังไม่มี มีแต่รูปกับ .md)
4. **อย่า** ติ๊ก "Add a README" / .gitignore / license (เพราะเรามีไฟล์อยู่แล้ว จะชนกัน)

จากนั้นผูก remote แล้ว push:

```powershell
cd "C:\Users\bpiec\OneDrive\Documents\Default Project\sec-writeups"

git remote add origin https://github.com/bawciarati/0xsec-writeups.git
git branch -M main
git push -u origin main
```

ตรวจว่า `.gitbook.yaml`, `SUMMARY.md`, `README.md` อยู่ที่ **root ของ repo** (ไม่ใช่ในโฟลเดอร์ย่อย) — สำคัญมาก

---

## 2. เชื่อม GitBook กับ repo (Git Sync)

GitBook ปัจจุบันตั้ง Git Sync ที่ **ระดับ site** (ไม่ใช่ระดับ space) — หนึ่ง connection ต่อ site หนึ่ง repo หนึ่ง branch
ตัวที่บอกว่า space ไหนอ่านโฟลเดอร์ไหน คือ `gitbook-docs.yaml` ที่ root ของ repo (มีอยู่แล้วในโปรเจกต์นี้)

1. เข้า gitbook.com → สร้าง **organization** (ตั้งชื่อ org เป็น `bpiecks` จะได้ subdomain `bpiecks.gitbook.io`)
2. สร้าง **site** ใหม่ ตั้งชื่อ `bpiecks`
3. ใน site → **Git Sync** (แถบซ้าย) → **Connect GitHub**
4. ติดตั้ง **GitBook GitHub App** เลือก **Only select repositories** → `bawciarati/0xsec-writeups`
5. **Source repository**: `0xsec-writeups`, branch `main`
6. **Initial sync direction**: เลือก **GitHub → GitBook** (repo เป็น source of truth — space ยังว่าง ไม่มีอะไรหาย)
7. **Project directory**: เว้นว่าง (repo root) — ที่เดียวกับ `gitbook-docs.yaml`
8. **Content mapping**: ตรวจว่ามีบรรทัด `bpiecks` → `./` (GitBook อ่านจาก `gitbook-docs.yaml` ให้อัตโนมัติ)
9. กด **Sync**

{% hint style="warning" %}
ถ้าเจอ error **`gitbook-docs.yaml does not exist on this branch`** แปลว่า repo ยังไม่มีไฟล์นี้ — ไฟล์ถูกเพิ่มให้แล้วใน commit ที่เพิ่ม `gitbook-docs.yaml` ให้ตรวจว่า push ขึ้น GitHub แล้ว แล้วกด Sync ซ้ำ
{% endhint %}

หลัง sync ครั้งแรก GitBook จะอ่าน:

| ไฟล์ | หน้าที่ |
| --- | --- |
| `gitbook-docs.yaml` | site ประกอบด้วย space อะไร, space ไหนอ่านโฟลเดอร์ไหน |
| `README.md` | หน้าแรกของ space (About Me) |
| `SUMMARY.md` | เมนูด้านซ้ายทั้งหมด |
| `.gitbook.yaml` | บอกว่า root อยู่ไหน, หน้าแรกชื่ออะไร, เมนูชื่ออะไร |

ไฟล์ที่ **ไม่อยู่ใน** `SUMMARY.md` (`SETUP.md`, `STYLE-GUIDE.md`, `templates/`, `detections/`) จะไม่ขึ้นในเมนู
`detections/*.yar` ยังเข้าถึงได้ทาง URL ตรง ๆ และลิงก์จากโพสต์ยังทำงาน

**ห้ามเปลี่ยน `key:` ใน `gitbook-docs.yaml`** หลัง sync ครั้งแรก — GitBook ถือว่า key ใหม่ = space ใหม่ (space ID ใหม่) ลิงก์เดิมจะพังทันที ถ้าอยากเปลี่ยนชื่อ ให้แก้ `title:` เท่านั้น

---

## 3. ตั้งหน้าตาเว็บ (ทำใน GitBook UI ไม่ใช่ใน git)

ทั้งหมดนี้ GitBook เก็บไว้ฝั่งแพลตฟอร์ม ไม่ลง repo:

- **Settings → Branding**: logo, favicon, สี
- **Settings → Themes**: โหมดสว่าง/มืด (0xSec ใช้ธีมมืด)
- **Settings → Domain**: ใส่ subdomain ฟรี `bpiecks.gitbook.io` หรือ custom domain
- **Settings → Social preview**: รูปตอนแชร์ลิงก์
- ปิด **suggest edits / comments** ถ้าไม่อยากให้คนอื่นแก้

> ถ้าแก้เมนูใน GitBook UI GitBook จะ commit `SUMMARY.md` กลับเข้า repo ให้ — อย่าแก้พร้อมกันสองฝั่งจะชนกัน ให้ถือว่า **git เป็น source of truth**

---

## 4. Workflow เวลาจะเขียนโพสต์ใหม่

```powershell
cd "C:\Users\bpiec\OneDrive\Documents\Default Project\sec-writeups"

# 1. ร่างโพสต์
Copy-Item templates\writeup-template.md malware-analysis\2026-12-01-my-sample.md

# 2. เติมเนื้อหา แล้วอัปเดต SUMMARY.md ให้มีลิงก์บรรทัดใหม่

# 3. commit + push
git add -A
git commit -m "post: my-sample static analysis"
git push
```

GitBook จะ sync ภายในไม่กี่วินาที

**กติกาสำคัญ 3 ข้อ**

1. แก้เนื้อหาใน editor (VS Code) แล้ว push — อย่าแก้ใน GitBook UI พร้อมกัน
2. อย่าแก้ `README.md` ใน GitBook UI (GitBook เตือนเรื่อง conflict เอง)
3. หลังเพิ่มไฟล์ **ต้องอัปเดต `SUMMARY.md`** ไม่งั้นจะไม่ขึ้นเมนู

---

## 5. Identity ที่ผูกไว้แล้ว

ทั้งหมดนี้แทนที่ให้เรียบร้อยแล้ว — ไม่มี placeholder เหลือ:

| ค่า | ใช้ที่ |
| --- | --- |
| `bpiecks` | ชื่อที่ใช้เขียนโพสต์ (`meta.author` ในกฎ YARA) |
| [`bawciarati`](https://github.com/bawciarati) | GitHub (Contact ใน `README.md`, remote ของ repo) |
| `bpieckrafale@hotmail.com` | `README.md` (Contact) |
| `https://bpiecks.gitbook.io/bpiecks/…` | `meta.reference` ของกฎ YARA |

**สิ่งที่ต้องเช็กเอง 1 อย่าง:**

- **GitBook URL** — `meta.reference` เดาโครงเป็น `bpiecks.gitbook.io/bpiecks/...` ถ้าคุณตั้งชื่อ space ไม่ใช่ `bpiecks` ให้แก้ URL ในกฎ YARA ให้ตรง (เปลี่ยนแค่บรรทัด `reference`)

ไม่ได้ใส่ลิงก์ X ไว้ (ตามที่สั่งลบ) ถ้าภายหลังอยากเพิ่ม ให้เติมต่อท้ายบรรทัด Contact ใน `README.md`

ตรวจว่าไม่มี placeholder หลุด:

```powershell
Get-ChildItem -Recurse -Include *.md,*.yar |
  Where-Object { $_.Name -notin 'SETUP.md', 'STYLE-GUIDE.md' } |
  Select-String -Pattern "YOURNAME|0xYOURHANDLE|YOUR_EMAIL"
```

ถ้าคำสั่งนี้ไม่คืนอะไรเลย = เรียบร้อย

---

## 6. ตรวจงานก่อนขึ้นเว็บ

- [ ] `git push` สำเร็จ และ GitHub เห็นไฟล์ครบ
- [ ] GitBook sync ผ่าน ไม่มี error ใน Settings → Git Sync
- [ ] เปิดหน้าแรกแล้วเห็น About Me
- [ ] เมนูซ้ายมี 4 หมวด + โพสต์ DBDAxera
- [ ] เปิดโพสต์แล้วรูปโลโก้ขึ้น (ถ้าไม่ขึ้น ตรวจ path `../assets/dbdaxera-logo.png`)
- [ ] ลิงก์ `detections/dbdaxera_updater.yar` เปิดได้
- [ ] แทน placeholder ครบ
- [ ] ตั้ง domain + favicon แล้ว

---

## 7. เรื่องที่ต้องคิดเอง (ผมตัดสินใจแทนไม่ได้)

- **ชื่อเว็บ / ชื่อคุณ**: ใช้ชื่อจริงหรือแฮนเดิล? ถ้าใช้แฮนเดิลเดียวกันกับที่อื่นจะดีต่อการสะสมชื่อเสียง
- **Public หรือ Private**: ถ้าเป็น portfolio ควร public — แต่โพสต์ที่เขียนถึงระบบของลูกค้า/ที่ทำงานต้อง anonymize ก่อน
- **จะลงตัวอย่าง malware ไหม**: อย่าลงใน repo สาธารณะ ให้ลงแค่แฮช + กฎ YARA (ตอนนี้ทำแบบนั้นอยู่แล้ว)
- **ภาษา**: ตอนนี้ H1 + TL;DR เป็นอังกฤษ ที่เหลือไทย ถ้าอยากได้ทั้งเว็บอังกฤษด้วย ต้องทำแยกอีก space (GitBook รองรับหลาย space ต่อ site)
