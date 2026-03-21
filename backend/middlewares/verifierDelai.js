const db = required("..//db");

function verifierDelai(req, res, next) {
    const now = new Date();

    db.query(
        'SELECT * FROM period_de_saisie WHERE statue = "ouvert" AND date_ouverture <= ?',
        [now,now], (err, results) => {
            if(err)
                return res.status(500).json({error: err.message});
            if (results.length === 0)
                return res.status(403).json({message: "Aucune periode de saisie ouverte"});
            req.periode = results[0];
            next();
        }
    );
}

module.exports = verifierDelai;