
// const nodemailer = require('nodemailer');

// // SMTP beállítások
// const transporter = nodemailer.createTransport({
//     host: 'smtp.localhost',
//     port: 587,
//     secure: false,
//     auth: {
//       user: 'email1',
//       pass: 'abc123' // Ha kétlépcsős azonosítás van, az "Alkalmazás-jelszó" legyen itt
//     },
//     debug: true, // Többlet debug információk
//     logger: true // Logolás a konzolba
//   });
  
  

// // E-mail küldő funkció
// const sendEmail = (to, subject, message) => {
//   const mailOptions = {
//     from: 'email1@localhost',
//     to: to,
//     subject: subject,
//     text: message
//   };

//   transporter.sendMail(mailOptions, (error, info) => {
//     if (error) {
//       console.error('Hiba az e-mail küldésekor:', error);
//     } else {
//       console.log('E-mail elküldve:', info.response);
//     }
//   });
// };

// // Exportálás a műszakvezetőknek szánt értesítéshez
// const notifySupervisors = (bugName) => {
//   const supervisors = ['supervisor1@example.com', 'supervisor2@example.com'];
//   const subject = 'Új hiba lett rögzítve';
//   const message = `Új hiba lett rögzítve: ${bugName}. Ellenőrizd a részleteket a portálon.`;
//   sendEmail(supervisors.join(','), subject, message);
// };

// // Exportálás a rendszergazdának szánt értesítéshez
// const notifyAdmin = (adminEmail, bugName) => {
//   const subject = 'Hozzád lett rendelve egy hiba';
//   const message = `A következő hiba hozzád lett rendelve: ${bugName}. Ellenőrizd a részleteket a portálon.`;
//   sendEmail(adminEmail, subject, message);
// };

// module.exports = {
//   notifySupervisors,
//   notifyAdmin
// };