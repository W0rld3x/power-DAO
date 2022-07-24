import React from "react";
import "./App.css";
import { Routes, Route } from "react-router-dom";
import Home from "./pages/Home";
import Proposal from "./pages/Proposal";
import {ConnectButton} from "web3uikit";
import PowerDAO from "./images/PowerDAO.png";

const App = () => {
  return (
    <>
    
    <div className="header">
    <img width="180px" src={PowerDAO} alt="logo" />
    <ConnectButton />

    </div>


      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/proposal" element={<Proposal />} />
      </Routes>
    </>
  );
};

export default App;
