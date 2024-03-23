import { useState} from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";

function SignUp() {
   const navigate = useNavigate();

   const [formData, setFormData] = useState({
      email: "",
      username: "",
      password: ""
   });

   function handleSubmit(e) {
      e.preventDefault();

      axios.post("http://localhost:3000/signup", formData)
         .then(response => {
            console.log(response.data);
            goSingIn();
         })
         .catch(error => {
            console.log(error);
         })
   }

   function handleChange(e) {
      const {name, value} = e.target;
      setFormData(prev => ({
         ...prev, [name]: value
      }));
   }

   function goSingIn() {
      navigate("/signin");
   }

   return <div>
      <div className="w-1/3 h-2/3 mt-40 mx-auto">
         <div className="text-center mb-3">
            <h3 className="scroll-m-20 text-2xl font-semibold tracking-tight">SignUp</h3>
            <h1 className="leading-7 tracking-tight">Already have an account? <span onClick={goSingIn} className="cursor-pointer text-blue-700">Login</span></h1>
         </div>
         
         <form onSubmit={handleSubmit}>
            <Input type="email"  placeholder="email" value={formData.email} name="email" onChange={handleChange}  className="mt-1 w-96"/>
            <Input type="text"  placeholder="username" value={formData.username} name="username" onChange={handleChange} className="mt-1 w-96"/>
            <Input type="password"  placeholder="password" value={formData.password} name="password" onChange={handleChange} className="mt-1 w-96"/>
            <Button type="submit" className="mt-1">SignUp</Button>
         </form>

      </div>
      
   </div>
}

export default SignUp;