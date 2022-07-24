import React, { useState, useEffect } from "react";
import "./pages.css";
import { TabList, Tab, Widget, Tag, Table, Form, Icon, Tooltip, Blockie}  from "web3uikit";
import { Link } from "react-router-dom";


const Proposal = () => {

  const [votes, setVotes] = useState([
    [
      [
        "0x4d2044D8D568c1644158625930De62c4AbBB004a",
        <Icon fill="#268c41" size={24} svg="checkmark" />,
      ],
      [
        "0x4d2044D8D568c1644158625930De62c4AbBB004a",
        <Icon fill="#268c41" size={24} svg="checkmark" />,
      ],
      [
        "0x4d2044D8D568c1644158625930De62c4AbBB004a",
        <Icon fill="#d93d3d" size={24} svg="arrowCircleDown" />,
      ],
      [
        "0x4d2044D8D568c1644158625930De62c4AbBB004a",
        <Icon fill="#d93d3d" size={24} svg="arrowCircleDown" />,
      ],
      [
        "0x4d2044D8D568c1644158625930De62c4AbBB004a",
        <Icon fill="#d93d3d" size={24} svg="arrowCircleDown" />,
      ],
    ]
  ]);


  return (
    <>
      <div className="contentProposal">
      <div className="proposal">
        <Link to="/">
          <div className="backHome">
            <Icon fill="#ffffff" size={20} svg="chevronLeft" />
            Overview
            </div>
        </Link>
        <div>Should we accept Elon Musks $44 billion offer for our DAO?</div>
        <div className="proposalOverview">
        <Tag color={"red"} text={"Rejected"} />
        <div className="proposer">
          <span> Proposed by </span>
          <Tooltip content={"0xAc4285F6e84fdC1a49a292742f30eff019E5acA1"}>
              <Blockie seed={"0xAc4285F6e84fdC1a49a292742f30eff019E5acA1"}> </Blockie>
          </Tooltip>
        </div>
        </div>
     </div>

        <div className="widgets">
          <Widget info={10} title="Votes for">
            <div className="extraWidgetInfo">
            <div className="extraTitle">{25}%</div>
            <div className="progress">
          <div 
          className="progressPercentage"
          style={{ width: `${25}%`}}
          ></div>
          </div>
          </div>
          </Widget>
          <Widget info={30} title="Votes Against">
            <div className="extraWidgetInfo">
              <div className="extraTitle">{75}%</div>
              <div className="progress">
            <div 
            className="progressPercentage"
            style={{ width: `${75}%`}}
            ></div>
            </div> 
            </div>
            </Widget>
         </div>
            <div className="votesDiv">
            <Table 
            style={{ width: "60%" }}
            columnsConfig="90% 10%"
            data={votes}
            header={[<span>Address</span>, <span>Vote</span>]}
            pageSize={5}
            />
            </div>
            </div>
            </>
  );
};

export default Proposal;
