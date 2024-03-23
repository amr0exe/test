import { BrowserRouter as Router, Routes, Link, Route } from "react-router-dom";

import SignUp from "./Pages/SignUp";
import SignIn from "./Pages/SignIn";
import ProtectedPage from "./Pages/ProtectedPage";

function App() {
   return <div>

      <Router>
         <Routes>
            <Route path="/signup" element={<SignUp />} />
            <Route path="/signin" element={<SignIn />} />
            <Route path="/protected" element={<ProtectedPage />} />
         </Routes>
      </Router>
   </div>
}

export default App
