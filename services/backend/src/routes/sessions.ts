import {Router} from 'express';
import multer from 'multer';
import path from 'path';
import fs from 'fs';
import prisma from '../lib/prismaClient';
const router = Router();
const upload = multer({ dest: path.join(__dirname, '../../uploads') });
router.post('/upload', upload.single('file'), async (req:any,res)=>{ if(!req.file) return res.status(400).json({error:'no_file'}); // TODO upload to S3. create session
 const data = fs.readFileSync(req.file.path);
 console.log('Uploaded file size', data.length);
 const session = await prisma.session.create({data:{profile_id:req.body.profile_id||'', facility_id:req.body.facility_id||'', source:'UPLOAD', video_url:'stub://local'}}); return res.json({ok:true,session}); });
router.post('/:id/process', async (req,res)=>{ const id=req.params.id; // mock process
 const fake = {emotion_summary:{dominant:'happy',distribution:{happy:0.75,sad:0.1,neutral:0.15}}, activity_summary:{active_minutes:30,sedentary_minutes:10,events:[]}, wellbeing_score:82};
 await prisma.session.update({where:{id}, data:{emotion_summary:fake.emotion_summary, activity_summary:fake.activity_summary, wellbeing_score:fake.wellbeing_score}}); return res.json({ok:true,result:fake}); });
export default router;
