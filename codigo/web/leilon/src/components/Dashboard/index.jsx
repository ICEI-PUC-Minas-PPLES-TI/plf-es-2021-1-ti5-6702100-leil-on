import Header from "../Header";
import lupa from "../../assets/lupa.jpg";
import iconePerfil from "../../assets/icone_perfil.jpg";
import martelo from "../../assets/martelo.jpg";
import { Button } from "react-bootstrap";

import "./Dashboard.css";

export default function Dashboard(props) {
  const { setPage } = props;

  return (
    <div>
      <Header />
      <div className="container">
        <div className="iconePerfil">
          <h3>Altere seu perfil.</h3>
          <img src={iconePerfil} alt="Lupa"></img>
          <Button
            className="btn btn-dark"
            onClick={() => {
              setPage("profile");
            }}
          >
            Alterar
          </Button>
        </div>
        <div className="martelo">
          <h3>Crie um leilão.</h3>
          <img src={martelo} alt="Lupa"></img>
          <Button
            className="btn btn-dark"
            onClick={() => {
              setPage("createAuction");
            }}
          >
            Criar
          </Button>
        </div>
        <div className="lupa">
          <h3>Procure por leilões.</h3>
          <img src={lupa} alt="Lupa"></img>
          <Button
            className="btn btn-dark"
            onClick={() => {
              setPage("searchAuction");
            }}
          >
            Procurar
          </Button>
        </div>
      </div>
    </div>
  );
}
