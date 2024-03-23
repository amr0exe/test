import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";

import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";

export default function SignIn() {
   const navigate = useNavigate();
   const [formData, setFormData] = useState({
      username: "",
      password: ""
   });

   function goSignUp() {
      navigate("/signup");
   }

   function handleChange(e) {
      const {name, value} = e.target;

      setFormData((prev )=> ({
         ...prev, [name]: value
      }))
   }

   function handleSubmit(e){
      e.preventDefault();

      axios.post("http://localhost:3000/signin", formData)
         .then(response => {
            const {msg, token} = response.data;
            console.log(msg);

            localStorage.setItem("token", token);
            navigate("/protected");
         }).catch((err) => {
            console.log(err);
         })
      // console.log("submitted!!");
      // console.log(formData);
   }

   return <div>
      <div className="w-1/3 h-2/3 mt-40 mx-auto">
         <div className="text-center">
            <h3 className="scroll-m-20 text-2xl font-semibold tracking-tight">SignIn</h3>
            <h1 className="leading-7 tracking-tight">Don't have an account? <span onClick={goSignUp} className="cursor-pointer text-blue-700">Register</span></h1>
         </div>

         <form onSubmit={handleSubmit}>
            <Input type="text"  placeholder="username" value={formData.username} name="username" onChange={handleChange} className="mt-1 w-96"/>
            <Input type="password"  placeholder="password" value={formData.password} name="password" onChange={handleChange} className="mt-1 w-96"/>
            <Button type="submit" className="mt-1">SignIn</Button>
         </form>
      </div>
   </div>
}