# FlatFinder - Project Guide

<!-- Google Font (best visible in Markdown viewers that allow HTML links/styles) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

<div style="font-family: 'Poppins', Arial, sans-serif;">

## Quick Intro
FlatFinder is a broker-free flat rental web app where owners post properties, seekers find homes, and admin checks listing quality.

## Tech Stack
| Area | Technology |
|---|---|
| Language | Java 17 |
| Backend | Spring Boot MVC |
| ORM | Spring Data JPA (Hibernate) |
| Frontend | JSP, JSTL, HTML, CSS, JavaScript |
| Database | MySQL |
| Build Tool | Maven |
| Email | SMTP (OTP + notifications) |

## Users
| User | Main Work |
|---|---|
| Seeker | Search flats and send inquiry |
| Owner | Add, edit, delete own properties |
| Admin | Approve/reject properties and manage platform |

## Core Features
| Feature | Description |
|---|---|
| Login/Register | User account creation and login |
| OTP Verification | Email OTP check after registration |
| Role Dashboard | Separate panels for Seeker, Owner, Admin |
| Property Management | Add, edit, delete, availability control |
| Image Upload | Upload multiple images for property |
| Smart Search | Search by keyword, location, and price |
| Inquiry System | Seeker contacts owner from property page |
| Admin Approval | Pending -> Approved/Rejected flow |
| Contact Support | Contact form with email alerts |

## JSP Pages (Approx.)
| Module | Pages |
|---|---:|
| Common/Public | 6 |
| Auth | 3 |
| Seeker | 6 |
| Owner | 4 |
| Admin | 8 |
| **Total** | **~27** |

## Project Flow
| Step | Flow |
|---:|---|
| 1 | User opens home page and sees approved properties |
| 2 | User registers and verifies email using OTP |
| 3 | User logs in and reaches role-based dashboard |
| 4 | Owner adds property (status = Pending) |
| 5 | Admin approves or rejects property |
| 6 | Approved property is visible to seekers |
| 7 | Seeker searches and opens property details |
| 8 | Seeker sends inquiry to owner |
| 9 | Owner checks inquiries and responds |

## Database Modules
| Entity |
|---|
| User |
| Property |
| Image |
| Inquiry |
| ContactMessage |

## Future Scope
- Add Google Maps location picker and nearby area view
- Add advanced filters (furnished, parking, pet-friendly)
- Add bookmark/wishlist for seekers
- Add in-app chat between owner and seeker
- Add payment/booking token system
- Add analytics dashboard for admin
- Add mobile app (Android/iOS)
- Add AI-based property recommendation

## Project Outcome
- Easy flat discovery without broker
- Fast communication between seeker and owner
- Better listing quality through admin approval

---
Icons used: 🏠 👤 🔍 📧 ✅ 📊 🚀

</div>
