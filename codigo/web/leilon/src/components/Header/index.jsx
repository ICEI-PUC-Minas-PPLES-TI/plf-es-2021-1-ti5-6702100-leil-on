import "./Header.css";
import { Button } from "react-bootstrap";
import { Link } from "react-router-dom";

function Header(props) {
  return (
    <div className="navbar">
      <Link to="/dashboard">
        <h3>Leil-on</h3>
      </Link>
      <Link to="/">
        <Button className="btn btn-danger">Logout</Button>
      </Link>
    </div>
  );
}

export default Header;
