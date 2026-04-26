
🏠 FlatFinder – Broker-Free Rental Platform

> A full-stack web application that connects flat owners and seekers directly — eliminating brokers, reducing friction, and improving listing quality through admin control.

---

## 🚀 Key Highlights

* 🔍 Smart property search with filters
* 👤 Role-based dashboards (Seeker / Owner / Admin)
* 📧 Email OTP verification system
* 🏠 Property listing with image uploads
* ✅ Admin approval workflow for quality control
* 💬 Inquiry system for direct communication

---

## 🛠 Tech Stack

| Layer            | Technology Used                  |
| ---------------- | -------------------------------- |
| 💻 Language      | Java 17                          |
| ⚙️ Backend       | Spring Boot MVC                  |
| 🗄 ORM           | Spring Data JPA (Hibernate)      |
| 🎨 Frontend      | JSP, JSTL, HTML, CSS, JavaScript |
| 🛢 Database      | MySQL                            |
| 🔧 Build Tool    | Maven                            |
| 📧 Email Service | SMTP (OTP + Notifications)       |

---

## 👥 User Roles & Responsibilities

### 🔍 Seeker

* Search flats using filters
* View property details
* Send inquiries to owners

### 🏠 Owner

* Add, update, delete properties
* Upload property images
* Manage inquiries

### 🛡 Admin

* Approve / Reject property listings
* Maintain platform quality
* Manage users and content

---

## ✨ Core Features

* 🔐 **Authentication System**

  * Registration & Login
  * Email OTP verification

* 📊 **Role-Based Dashboard**

  * Customized UI for each user type

* 🏡 **Property Management**

  * Add / Edit / Delete listings
  * Availability control

* 🖼 **Image Upload**

  * Multiple images per property

* 🔎 **Smart Search**

  * Filter by location, keyword, price

* 💬 **Inquiry System**

  * Direct communication between seeker & owner

* ✅ **Admin Moderation**

  * Approval workflow (Pending → Approved/Rejected)

* 📧 **Contact Support**

  * Email-based support system

---

## 📂 Project Structure Overview

```
FlatFinder/
│── controllers/
│── services/
│── repositories/
│── models/
│── jsp/
│── resources/
│── database/
```

---

## 📄 JSP Pages Distribution

| Module    |   Pages |
| --------- | ------: |
| 🌐 Public |       6 |
| 🔐 Auth   |       3 |
| 🔍 Seeker |       6 |
| 🏠 Owner  |       4 |
| 🛡 Admin  |       8 |
| **Total** | **~27** |

---

## 🔄 Application Workflow

1. 🌐 User visits homepage → sees approved properties
2. 📝 Registers account → verifies via OTP
3. 🔐 Logs in → redirected to role-based dashboard
4. 🏠 Owner adds property → status = *Pending*
5. 🛡 Admin reviews → Approves / Rejects
6. ✅ Approved listings become visible
7. 🔍 Seeker searches & views property
8. 💬 Seeker sends inquiry
9. 📩 Owner responds

---

## 🗄 Database Design

Core Entities:

* 👤 User
* 🏠 Property
* 🖼 Image
* 💬 Inquiry
* 📧 ContactMessage

---

## 🔮 Future Enhancements

* 📍 Google Maps integration (location picker)
* 🎯 Advanced filters (furnished, parking, pets)
* ❤️ Wishlist / Bookmark feature
* 💬 Real-time chat system
* 💳 Booking & payment integration
* 📊 Admin analytics dashboard
* 📱 Mobile app (Flutter / Android / iOS)
* 🤖 AI-based property recommendation

---

## 🎯 Project Outcome

* 🚫 Eliminates broker dependency
* ⚡ Faster and direct communication
* ✅ Ensures high-quality property listings
* 💡 Scalable architecture for future upgrades

---
