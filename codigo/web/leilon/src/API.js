import axios from "axios";

const API_URL = "http://leil-on.herokuapp.com/";

/**
 * Make a POST request to API with login data and to get accesss token.
 *
 * @returns access token.
 */
export async function getLoginToken(email, password) {
  try {
    const apiResponse = await axios({
      method: "post",
      url: API_URL + "authenticate/",
      headers: {
        "Content-Type": "application/json",
      },
      data: {
        email: email,
        password: password,
      },
    });

    return apiResponse.data.token;
  } catch (err) {
    if (err.response) {
      const { status } = err.response;

      switch (status) {
        case 403:
          throw String("Senha inválida!");
        default:
          throw String(
            "Email inválido! (Ou houve um problema no banco de dados, kkk)"
          );
      }
    } else {
      throw String("Não foi possível conectar ao servidor!");
    }
  }
}

/**
 * Make a POST request to the API to register a new user.
 */
export async function registerUser(email, password, name, telefone, cep) {
  try {
    const apiResponse = await axios({
      method: "post",
      url: API_URL + "adduser/",
      headers: {
        "Content-Type": "application/json",
      },
      data: {
        name: name,
        password: password,
        email: email,
        cep: cep,
        telefone: telefone,
      },
    });

    return Object.assign({}, apiResponse.data);
  } catch (err) {
    if (err.response) {
      throw String(
        "Houve um erro no servidor ao tentar registrar um novo usuário!"
      );
    } else {
      throw String("Não foi possível conectar ao servidor!");
    }
  }
}

/**
 * Make a GET request to the API to get data from a user with a specific email.
 */
// export async function getUserData(email, authToken) {
//   try {
//     const apiResponse = await axios({
//       method: "get",
//       url: API_URL + "/getinfo" + email,
//       headers: {
//         authorization: authToken,
//       },
//     });

//     if (apiResponse.status === 200) {
//       return apiResponse.data.user;
//     } else {
//       throw apiResponse.data.message;
//     }
//   } catch (err) {
//     throw err;
//   }
// }

/**
 * Make a POST request to the API to register a new auction.
 */
export async function registerAuction(name, items, owner, endDate) {
  try {
    const apiResponse = await axios({
      method: "post",
      url: API_URL + "addauction/",
      headers: {
        "Content-Type": "application/json",
      },
      data: {
        name: name,
        items: items,
        owner: owner,
        endDate: endDate,
      },
    });

    return Object.assign({}, apiResponse.data);
  } catch (err) {
    if (err.response) {
      throw String(
        "Houve um erro no servidor ao tentar registrar um novo leilão!"
      );
    } else {
      throw String("Não foi possível conectar ao servidor!");
    }
  }
}

/**
 * Make a POST request to the API to register a new item.
 */
export async function registerItem(
  name,
  price,
  image,
  itemOwner,
  linkedAuction,
  description,
  historic,
  highestbidder,
  categories
) {
  try {
    const apiResponse = await axios({
      method: "post",
      url: API_URL + "additem/",
      headers: {
        "Content-Type": "application/json",
      },
      data: {
        name: name,
        price: price,
        image: image,
        itemOwner: itemOwner,
        linkedAuction: linkedAuction,
        description: description,
        historic: historic,
        highestbidder: highestbidder,
        categories: categories,
      },
    });

    return Object.assign({}, apiResponse.data);
  } catch (err) {
    if (err.response) {
      throw String(
        "Houve um erro no servidor ao tentar registrar um novo item!"
      );
    } else {
      throw String("Não foi possível conectar ao servidor!");
    }
  }
}
