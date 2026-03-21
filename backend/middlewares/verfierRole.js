function verifierRole(Roles) {
    return (req, res, next) => {
        if (req.user.role !== Roles) {
            return res.status(403).json({ message: "Acces refuse" });
            next();
        };
    };
}

module.exports = verifierRole;