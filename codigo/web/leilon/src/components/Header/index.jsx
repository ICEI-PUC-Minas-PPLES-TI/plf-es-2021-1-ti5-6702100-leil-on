import "./Header.css";
import { Button } from "react-bootstrap";
import { Link } from "react-router-dom";

function Header(props) {
  return (
    <div className="navbar">
      <Link to="/dashboard">
        <Button className="btn btn-light">Leil-on</Button>
      </Link>
      <Link to="/">
        <Button className="btn btn-danger">Logout</Button>
      </Link>
    </div>
  );
}

export default Header;
