const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const db = require("../db");
const verifierToken = require("../middlewares/verifierToken");

//  POST/api/auth/login

router.post("/login", (req, res) =>{
    const {email, mot_de_passe} = req.body;

    console.log("Email recu: ", email);
    console.log("Mot de passe recu: ", mot_de_passe);

    if (!email || ! mot_de_passe)
        return res.status(400).json({message: "Email et mot de passe requis"});

    db.query(
        "SELECT * FROM utilisateurs WHERE email = ? AND actif = TRUE",
        [email], (err, results) => {
            if(err) 
                return res.status(500).json({error: err.message});

            if (results.length === 0)
                return res.status(404).json({message: "Utilisateur non trouve"});

            const user = results[0];

            console.log(" hash on bd: ", user.mot_de_passe);

            const valide = bcrypt.compareSync(mot_de_passe, user.mot_de_passe);
            if(!valide)
                return res.status(401).json({message: "Mot de passe incorrect"});

            const token = jwt.sign(
                {id: user.id, role: user.role},
                process.env.JWT_SECRET,
                {expiresIn: process.env.JWT_EXPIRES_IN}
            );

            res.json({
                message:"Connexion reussie", token, role: user.role,
                premier_connexion: ! user.mot_de_passe_change,
                nom: user.nom, prenom: user.prenom,
            });
        }
    );
});

// PUT/api/auth/change-passeword

router.put("/change-password", verifierToken, (req, res) =>{
    const {ancien, nouveau} = req.body;
    const {id} = req.user;

    bd.query(
        "SELECT mot_de_passe FROM utilisateurs WHERE id = ?", 
        [id], (err, results) => {
            if(err)
                return res.status(500).json({error: err.message});

            const valide = bcrpt.compareSync(ancien, results[0].mot_de_passe);
            if (!valide)
                return res.status(401).json({message: "Ancien mot de passe incorrect"});

            const hash = bcrypt.hashSync(nouveau, 10);
            db.query(
                "UPDATE utilisateur SET mot_de_passe = ?, mot_de_passe_change = TRUE WHERE id = ?",
                [hash, id], (err) => {
                    if(err)
                        return res.status(500).json({error: err.message});

                    res.json({message: "Mot de passe modifie"});
                }
            );
        }
    );
});

// GET/api/auth/me

router.get("/me", verifierToken, (req, res) => {
    const {id} = req.user;

    db.query(
        "SELECT u.id, u.nom, u.prenom, u.email, u.role, u.mot_de_passe_change, p.telephone FROM utilisateurs u LEFT JOIN professeurs p ON p.utilisateur_id = u.id WHERE u.id = ?",
        [id], (err, results) => {
            if(err)
                return res.status(500).json({error: err.message});

            res.json(results[0]);
        }
    )
})

module.exports = router;