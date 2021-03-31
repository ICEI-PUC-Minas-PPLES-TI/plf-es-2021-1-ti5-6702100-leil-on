import "./App.css";
import "bootstrap/dist/css/bootstrap.min.css";
import { useState } from "react";
import Login from "./components/Login";
import Register from "./components/Register";
import Dashboard from "./components/Dashboard";

function App() {
  const [currentPageName, setCurrentPageName] = useState("login");

  function getCurrentPageComponent() {
    return {
      login: <Login setPage={setCurrentPageName} />,
      register: <Register setPage={setCurrentPageName} />,
      dashboard: <Dashboard setPAge={setCurrentPageName} />,
    }[currentPageName];
  }
  return (
    <>
      <main className="Container App">
        <main>{getCurrentPageComponent()}</main>
      </main>
    </>
  );
}

export default App;
