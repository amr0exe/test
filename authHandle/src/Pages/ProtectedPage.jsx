import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
// import { useState } from "react"

export default function ProtectedPage() {
   // const [data, setData] = useState(null);

   // useEffect(() => {
   //    const token = localStorage.getItem("token");
   //    axios.get("/protected", {
   //       headers: {
   //          Authorization: `Bearer ${token}`
   //       }
   //    }).then(res => {
   //       setData(res.data);
   //    }).catch(err => {
   //       console.log(err);
   //    })
   // }, [])

   return <div className="bg-zinc-800 h-screen">
      <div className="bg-zinc-950 p-2 flex justify-between items-center">
         <h1 className="ml-20 text-slate-200  font-sans">protectedPage</h1>

         <div className="flex justify-between items-center">         
            <h1 className="text-slate-50 mr-2 font-sans">amr</h1>
            <Avatar className="mr-20">
               <AvatarImage src="https://github.com/shadcn.png" />
               <AvatarFallback>CN</AvatarFallback>
            </Avatar>
         </div>
      </div>
   </div>
}