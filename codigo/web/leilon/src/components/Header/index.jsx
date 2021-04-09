import "./Header.css";
import { Button } from "react-bootstrap";

function Header(props) {
  const { setPage } = props;

  return (
    <div className="navbar">
      <Button
        className="btn btn-light"
        onClick={() => {
          setPage("dashboard");
        }}
      >
        Leil-on
      </Button>
      <Button
        className="btn btn-danger"
        onClick={() => {
          setPage("login");
        }}
      >
        Logout
      </Button>
    </div>
  );
}

export default Header;
