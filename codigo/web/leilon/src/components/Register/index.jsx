import React, { useState } from "react";
import { Button, Form, Row, Alert } from "react-bootstrap";
import { registerUser } from "../../API";
import "./Register.css";

/**
 * User Registration component.
 */
function Register(props) {
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [cell, setCell] = useState("");
  const [cep, setCep] = useState("");
  const [showAlert, setShowAlert] = useState(false);
  const [alertContent, setAlertContent] = useState("");

  const { setPage } = props;

  function handleSubmit(event) {
    event.preventDefault();

    if (!(name, email, password) || cell === 0 || cep === 0) {
      setAlertContent("Preencha os dados corretamente!");
      setShowAlert(true);
      return;
    }

    registerUser(email, password, name, cell, cep)
      .then((responseData) => {
        const { token } = responseData;
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
    <div className="register">
      <Row className="justify-content-md-center">
        <h1 className="pageTitle">Leil-on</h1>
      </Row>
      <Row className="justify-content-md-center">
        <Form>
          <Row className="justify-content-md-center row-cols-1">
            <Form.Group controlId="registerName">
              <Form.Label>Nome</Form.Label>
              <Form.Control
                onChange={(e) => setName(e.target.value)}
                value={name}
                type="text"
              />
            </Form.Group>
          </Row>
          <Row className="justify-content-md-center row-cols-1">
            <Form.Group controlId="registerEmail">
              <Form.Label>Email</Form.Label>
              <Form.Control
                onChange={(e) => setEmail(e.target.value)}
                value={email}
                type="email"
              />
            </Form.Group>
          </Row>
          <Row className="justify-content-md-center row-cols-1">
            <Form.Group controlId="registerPassword">
              <Form.Label>Senha</Form.Label>
              <Form.Control
                onChange={(e) => setPassword(e.target.value)}
                value={password}
                type="password"
              />
            </Form.Group>
          </Row>
          <Row className="justify-content-md-center row-cols-1">
            <Form.Group controlId="registerCell">
              <Form.Label>Celular</Form.Label>
              <Form.Control
                onChange={(e) => setCell(e.target.value)}
                value={cell}
                type="number"
              />
            </Form.Group>
          </Row>
          <Row className="justify-content-md-center row-cols-1">
            <Form.Group controlId="registerCep">
              <Form.Label>Cep</Form.Label>
              <Form.Control
                onChange={(e) => setCep(e.target.value)}
                value={cep}
                type="number"
              />
            </Form.Group>
          </Row>

          <Row className="justify-content-md-center">
            <Button
              onClick={handleSubmit}
              className="registrationButton"
              variant="primary"
              type="Submit"
            >
              Registrar
            </Button>
            <Button
              onClick={() => {
                setPage("login");
              }}
              className="registrationButton"
              variant="warning"
            >
              Cancelar
            </Button>
          </Row>
        </Form>
      </Row>
      <Row className="justify-content-md-center">
        {showAlert ? <Alert variant="danger">{alertContent}</Alert> : <></>}
      </Row>
    </div>
  );
}

export default Register;
