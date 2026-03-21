/*
    C'est lui qui:
        -> Demarre le serveur expresse
        -> Charge les middlewares globaux (cors, json parsing)
        -> Defini les routes API
        -> Ecoute les requetes du frontend
*/

const express = require("express");
const cors = require("cors");
require("dotenv").config();

const app = express();

//-------------------- Middleware ------------------    
app.use(cors());
app.use(express.json());

//------------------- Routes -------------------------
app.use("/api/auth", require("./routes/auth"));

//-------------------- Route de test ------------------
app.get("/", (req, res) => {
    res.json({ message: "Bienvenue sur l'API GradeBook!" });
});

//-------------------- Demarrer le serveur ------------------
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Serveur demarre sur http://localhost:${PORT}`);
});