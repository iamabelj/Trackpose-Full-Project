import jwt from 'jsonwebtoken';
const SECRET=process.env.JWT_SECRET||'dev-secret';
export function sign(payload:any, expires='7d'){ return jwt.sign(payload, SECRET, {expiresIn:expires}); }
export function verify(token:string){ return jwt.verify(token, SECRET); }
