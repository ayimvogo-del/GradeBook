const jwt = require("jsonwebtoken");

function verifierToken(req, rres, next) {
    const authHeader = req.headers.authorization;
    if (!authHeader) 
        return res.status(401).json({ message: "Token manquant" });

    const token = authHeader.split(" ")[1];

    try {
        const decoode = jwt .verify(token, process.env.JWT_SECRET);
        req.user = decoded; // {id, role}
        next ();
    } catch{
        return res.status(401).json({ message: "Token invalide" });
    }
}

module.exports = verifierToken;