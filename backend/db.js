/*  - Se fichier etablit le lien entre Node.js et la baase de donnees MySQL.
    - Lis les infos du fichier .env et cree une connexion a MySQL  
*/

const mysql = require('mysql2');
require("dotenv").config();

const db = mysql.createConnection({
    host: process.env.DB_Host,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
});

db.connect((err) => {
    if (err) {
        console.error("Erreur de connexion MySQL:", err.message);
    }else {
        console.log("Connecte a MySQL !");
    }
});

module.exports = db;

