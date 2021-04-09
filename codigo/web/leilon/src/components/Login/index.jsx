import React, { useState } from "react";
import { Button, Form, Row, Alert } from "react-bootstrap";
import { getLoginToken } from "../../API";
import "./Login.css";

/**
 * User Login component.
 */
function Login(props) {
  localStorage.clear();

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [showAlert, setShowAlert] = useState(false);
  const [alertContent, setAlertContent] = useState("");

  const { setPage } = props;

  function handleSubmit(event) {
    event.preventDefault();

    if (!(email && password)) {
      setAlertContent("Preencha os dados de login corretamente!");
      setShowAlert(true);
      return;
    }

    getLoginToken(email, password)
      .then((token) => {
        localStorage.setItem("email", email);
        localStorage.setItem("token", token);
        setPage("dashboard");
      })
      .catch((err) => {
        setAlertContent(err.toString());
        setShowAlert(true);
      });
  }

  return (
    <div className="login">
      <Row className="justify-content-md-center login-title">
        <h1 className="title">Leil-on</h1>
      </Row>
      <Row className="justify-content-md-center">
        <Form className="">
          <Form.Group controlId="loginEmail">
            <Form.Label>Email</Form.Label>
            <Form.Control
              onChange={(e) => setEmail(e.target.value)}
              value={email}
              type="email"
            />
          </Form.Group>
          <Form.Group controlId="loginPassword">
            <Form.Label>Senha</Form.Label>
            <Form.Control
              onChange={(e) => setPassword(e.target.value)}
              value={password}
              type="password"
            />
          </Form.Group>
          <Button
            onClick={handleSubmit}
            className="loginButton"
            variant="primary"
            type="Submit"
          >
            Entrar
          </Button>
          <Button
            onClick={() => {
              setPage("register");
            }}
            className="registerButton"
            variant="warning"
          >
            Registrar
          </Button>
        </Form>
      </Row>
      <Row className="justify-content-md-center">
        {showAlert ? <Alert variant="danger">{alertContent}</Alert> : <></>}
      </Row>
    </div>
  );
}

export default Login;
