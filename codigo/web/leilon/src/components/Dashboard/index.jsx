import Header from "../Header";
import lupa from "../../assets/lupa.jpg";
import iconePerfil from "../../assets/icone_perfil.jpg";
import martelo from "../../assets/martelo.jpg";
import { Button } from "react-bootstrap";
import { Link } from "react-router-dom";

import "./Dashboard.css";

export default function Dashboard(props) {
  return (
    <div>
      <Header />
      <div className="container">
        <div className="iconePerfil">
          <h3>Altere seu perfil.</h3>
          <img src={iconePerfil} alt="Lupa"></img>
          <Link to="/profile">
            <Button className="btn btn-dark">Alterar</Button>
          </Link>
        </div>
        <div className="martelo">
          <h3>Crie um leilão.</h3>
          <img src={martelo} alt="Lupa"></img>
          <Link to="/createauction">
            <Button className="btn btn-dark">Criar</Button>
          </Link>
        </div>
        <div className="lupa">
          <h3>Procure por leilões.</h3>
          <img src={lupa} alt="Lupa"></img>
          <Link to="searchauction">
            <Button className="btn btn-dark">Procurar</Button>
          </Link>
        </div>
      </div>
    </div>
  );
}
