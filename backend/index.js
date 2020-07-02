const express = require("express");
const app = express();
const jwt = require("jsonwebtoken");
const PORT = 3000;
const SECRET = "FsfTU#32^om!zFdQSwGf";

const user = "w1ll-dev";
const pswd = "12345";

const contacts = require("./contacts.json");
function checkAuth(req, res, next) {
    if (req.path !== "/login") {
        const token = req.headers["authorization"];
        if (!token) return res.status(401).send("token not found");
        jwt.verify(token, SECRET, (err, decode) => {
            if (err) return res.status(500).send({ "message": "Denied access" })
            req.userId = decode.id;
            next();
        });
    } else {
        next();
    }
}

app.use(checkAuth);
app.use(express.json());
app.listen(PORT, () => console.log("SERVER RUNNING!"));

app.post("/login", (req, res) => {
    if (req.body.user === user && req.body.pswd === pswd) {
        const id = "1";
        const token = jwt.sign({ id }, SECRET, { expiresIn: 3000 });
        res.send({ "token": token });
    } else {
        res.status(403).send("Denied access.");
    }
});

app.get("/", (req, res) => res.send({ "message": "hello world!" }));
app.get("/contacts", (req, res) => res.send(contacts));
app.get("/contacts/filter", (req, res) => {
    const name = req.query.name;
    const filterdContacts = contacts.filter(c => c.complete_name.toLowerCase().includes(name.toLowerCase()));
    res.send(filterdContacts);
});