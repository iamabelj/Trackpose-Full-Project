import {Router} from 'express';
import prisma from '../lib/prismaClient';
import bcrypt from 'bcrypt';
import {sign} from '../lib/jwt';
const router = Router();
router.post('/signup', async (req,res)=>{ const {full_name,email,password,role}=req.body; const password_hash=await bcrypt.hash(password,10); const user=await prisma.user.create({data:{full_name,email,password_hash,role}}); const code=Math.floor(100000+Math.random()*900000).toString(); console.log('VERIF CODE',code); return res.json({ok:true,userId:user.id}); });
router.post('/verify-email', async (req,res)=>{ const {email,code}=req.body; // TODO: check code store; mark verified
 await prisma.user.updateMany({where:{email}, data:{email_verified:true}}); return res.json({ok:true}); });
router.post('/login', async (req,res)=>{ const {email,password}=req.body; const user=await prisma.user.findUnique({where:{email}}); if(!user) return res.status(401).json({error:'invalid'}); const match=await bcrypt.compare(password,user.password_hash||''); if(!match) return res.status(401).json({error:'invalid'}); const token=sign({sub:user.id,role:user.role}); return res.json({ok:true,token}); });
export default router;
