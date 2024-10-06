class StringConsts {

  static final String htmlContent = """
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./style/home.css">
    <title>THUNDER API COLLECETION</title>
</head>

<body>

    <header>
        <nav>
            <div class="logo">
                <img src="assets/images/logo.png" class="logo-image" alt="logo">
                <label>Thunder</label>
            </div>
            <ul>
                <li><a href="https://github.com/AbdAlftahSalem">GitHub</a></li>
                <li><a href="https://wa.me/00972598045064">WhatsApp</a></li>
                <li><a href="https://t.me/Abd_Alftah_Al_shanti">Telegram</a></li>
            </ul>
        </nav>
    </header>

    <div class="container">

        <div class="section info">
            <p>Collection info </p>
            <img src="assets/images/icon-arrow-down.svg" alt="">
        </div>

        <div class="detail-section info-details">
            <p></p>
            <p></p>
        </div>


        <div class="section variables">
            <p>Variables </p>
            <img src="assets/images/icon-arrow-down.svg" alt="">
        </div>

        <div class="detail-section variables-deatils">
            <p></p>
            <p></p>
        </div>

        <div class="section requests">
            <p>Requests </p>
            <img src="assets/images/icon-arrow-down.svg" alt="">
        </div>

        <div class="detail-section requests-deatils">
        </div>


    </div>

    <script src="./js/data.js"></script>
    <script src="./js/home.js"></script>
</body>

</html>  
""";

  static final String styleContent =  """
* {
  margin: 0;
}

body {
  background-color: #eee;
}

ul {
  list-style: none;
  display: flex;
}

a {
  text-decoration: none;
  color: white;
}

ul li {
  margin-left: 16px;
}

header {
  background: linear-gradient(45deg, #010758, #490d61);
  position: fixed;
  width: 100%;
  z-index: 999;
  box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.5);
}

nav {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 12px 70px;
}

.container {
  /* padding: 12px 70px; */
  padding: 10% 70px;
}

.logo {
  display: flex;
  flex-direction: row;
  align-items: center;
  color: white;
  font-size: 24px;
}

.logo-image {
  width: 48px;
}

.section {
  padding: 24px;
  background-color: rgb(223 221 221);
  margin-top: 48px;
  margin-bottom: 16px;
  font-size: 24px;
  font-weight: 600;
  border-radius: 12px;
  display: flex;
  align-items: center;
  position: relative;
  justify-content: space-between;
}

.section img {
  width: 22px;
  transition: 0.3s;
}

.detail-section {
  background-color: rgb(223 221 221 / 50%);
  padding: 24px;
  letter-spacing: 1.5px;
  border-radius: 12px;
  margin-left: 36px;
  display: none;
}

.sub-section {
  background: #d5d5d5;
  margin-top: 4px;
  padding: 12px;
  border-radius: 8px;
}

.request {
  background: linear-gradient(45deg, #010758, #490d61);
  color: white;
  padding: 12px;
  margin: 8px;
  margin-bottom: 24px;
  border-radius: 12px;
}
.request-method-and-route {
  display: block;
  background-color: #5e35b1a3;
  padding: 14px;
  border-radius: 8px;
  margin-bottom: 12px;
  color: white;
  line-height: 1.4;
}

.request-body {
  color: white;
  background-color: #490d61;
  padding: 12px;
  border-radius: 8px;
  margin-bottom: 12px;
}

.request-header {
  color: white;
  background-color: #5e35b1a3;
  padding: 12px;
  margin-bottom: 12px;
  border-radius: 8px;
  line-height: 1.4;
}

.request-auth {
  background-color: #490d61;
  color: white;
  padding: 12px;
  border-radius: 8px;
  margin-bottom: 12px;
}

""";

  static final String homeJSContent = r"""
const infoSectionElement = document.querySelector(".info");
const detailInfoSectionElement = document.querySelector(".info-details");
const arrowDetailInfoSectionElement = document.querySelector(".info img");

const variablesSectionElement = document.querySelector(".variables");
const detailvariablesSectionElement =
  document.querySelector(".variables-deatils");
const arrowVariablesSectionElement = document.querySelector(".variables img");

const requestsSectionElement = document.querySelector(".requests");
const detailRequestsSectionElement =
  document.querySelector(".requests-deatils");
const arrowRequestsSectionElement = document.querySelector(".requests img");

// let requestsData = {};

const toggleDisplay = (sectionElement, arrowElement) => {
  if (sectionElement.style.display === "block") {
    sectionElement.style.display = "none";
    arrowElement.style.transform = `rotate(0deg)`;
  } else {
    sectionElement.style.display = "block";
    arrowElement.style.transform = `rotate(180deg)`;
  }
};

const setupInfoData = () => {
  detailInfoSectionElement.innerHTML = `<div class="sub-section" style = "font-weight: bold; font-size : 18px; line-height: 1.5;"> <labale>Collection name : <span>${requestsData.info.name}</spna></labale><br><labale>Base URL : ${requestsData.variables[0].value}</labale> </div>`
}

const setupVariablesData = async function () {
  let variablesData = "";
  for (var i in requestsData.variables) {
    variablesData += `<div class = "sub-section"><lable style = "font-weight: bold; font-size : 18px">${detailInfoSectionElement.innerHTML = `<div class="sub-section" style = "font-weight: bold; font-size : 18px; line-height: 1.5;"> <labale>${requestsData.variables[i].key} : <span>${requestsData.variables[i].value}</spna></labale></div>`}`;
  }

  detailvariablesSectionElement.innerHTML = variablesData;
};

const setupRequestsData = async function () {
  detailRequestsSectionElement.innerHTML = "";
  for (var requestFoldernameIndex in requestsData["item"]) {
    let requestFoldername = requestsData.item[requestFoldernameIndex];
    let requestSection = document.createElement("div");

    requestSection.classList.add("section");
    requestSection.classList.add("sub-section-requests");

    let requestFolderName = document.createElement("p");
    requestFolderName.innerHTML = requestFoldername.name;

    let arrow = document.createElement("img");
    arrow.classList.add(`arrow-${requestFoldername.name}`);
    arrow.src = "assets/images/icon-arrow-down.svg";

    requestSection.appendChild(requestFolderName);
    requestSection.appendChild(arrow);

    let detailRequests = document.createElement("div");
    detailRequests.classList.add(
      "detail-section",
      `${requestFoldername.name}-sub-section`
    );

    detailRequestsSectionElement.appendChild(requestSection);
    detailRequestsSectionElement.appendChild(detailRequests);
  }

  const subSectionRequests = document.querySelectorAll(".sub-section-requests");

  subSectionRequests.forEach((request) => {
    request.addEventListener("click", () => {
      let folderRequestNameElement = document.querySelector(
        `.${request.textContent}-sub-section`
      );

      let arrow = document.querySelector(`.arrow-${request.textContent}`);

      let folderRequestName = request.textContent;
      folderRequestNameElement.classList.add("sub-section");
      folderRequestNameElement.style.display =
        folderRequestNameElement.style.display === "block" ? "none" : "block";

      if (folderRequestNameElement.style.display === "block") {
        arrow.style.transform = "rotate(180deg)";
      } else {
        arrow.style.transform = "rotate(0deg)";
      }

      const requestsShow = requestsData.item.filter(
        (item) =>
          item.name.toLowerCase() === folderRequestName.toLocaleLowerCase()
      );

      let requestDiv = document.createElement("div");

      for (let i = 0; i < requestsShow[0].item.length; i++) {
        let requestDivLocale = document.createElement("div");
        requestDivLocale.className = "request";

        let requestRouteAndMethodElement = document.createElement("div");
        let bodyRequestElement = document.createElement("div");
        let headersRequestElement = document.createElement("div");
        let authRequestElement = document.createElement("div");

        requestRouteAndMethodElement.classList.add("request-method-and-route");
        bodyRequestElement.classList.add("request-body");
        headersRequestElement.classList.add("request-header");
        authRequestElement.classList.add("request-auth");

        let currentRequest = requestsShow[0].item[i];

        let requestTitle = document.createElement("h2");
        requestTitle.innerHTML = `${currentRequest.name}`;
        requestTitle.style.marginBottom = "12px";
        requestDivLocale.appendChild(requestTitle);

        // request route and method
        requestRouteAndMethodElement.innerHTML = `[ ${currentRequest.request.method} ] || ${currentRequest.request.url.raw}`;
        requestDivLocale.appendChild(requestRouteAndMethodElement);

        // add body
        if (currentRequest.request.body) {
          if (
            currentRequest.request.body.mode.toLocaleLowerCase() === "raw" &&
            currentRequest.request.body.raw.length > 0
          ) {
            bodyRequestElement.innerHTML = `<h5 style = 'margin-bottom : 6px'>Body : </h5>${currentRequest.request.body.raw}`;
            requestDivLocale.appendChild(bodyRequestElement);
          } else if (
            currentRequest.request.body.mode.toLocaleLowerCase() === "formdata"
          ) {
            let bodyData = {};
            console.log(
              `${currentRequest.name} ${currentRequest.request.body}`
            );
            for (
              var bodyIndex = 0;
              bodyIndex < currentRequest.request.body.formdata.length;
              bodyIndex++
            ) {
              let bodyItem = currentRequest.request.body.formdata[bodyIndex];
              console.log(bodyItem);
              bodyData[bodyItem.key] =
                bodyItem.type === "text" ? bodyItem.value : bodyItem.src;
            }
            bodyRequestElement.innerHTML = `<h4>Body : </h4> <br> ${JSON.stringify(
  bodyData
  )}`;
            requestDivLocale.appendChild(bodyRequestElement);
          }
        }

        // setup headers
        if (currentRequest.request.header) {
          let headerData = "<h5 style = 'margin-bottom : 6px'>Headers : </h5>";

          for (
            var headerIndex = 0;
            headerIndex < currentRequest.request.header.length;
            ++headerIndex
          ) {
            let headerItem = currentRequest.request.header[headerIndex];
            headerData += `<div><lable>${headerItem.key}</lable> : <lable> ${headerItem.value}</lable> <br></div>`;
          }

          headersRequestElement.innerHTML = headerData;
          requestDivLocale.appendChild(headersRequestElement);
        }

        // setup auth
        if (
          currentRequest.request.auth &&
          currentRequest.request.auth.auth.length > 0
        ) {
          authRequestElement.innerHTML = `<h4>Auth : </h4> <br>${currentRequest.request.auth.auth[0].key} : ${currentRequest.request.auth.type} ${currentRequest.request.auth.auth[0].value}`;
          requestDivLocale.appendChild(authRequestElement);
        }
        requestDiv.appendChild(requestDivLocale);
      }

      folderRequestNameElement.appendChild(requestDiv);
    });
  });
};

infoSectionElement.addEventListener("click", () => {
  toggleDisplay(detailInfoSectionElement, arrowDetailInfoSectionElement);
  setupInfoData();
});
variablesSectionElement.addEventListener("click", () => {
  toggleDisplay(detailvariablesSectionElement, arrowVariablesSectionElement);
  setupVariablesData();
});
requestsSectionElement.addEventListener("click", () => {
  toggleDisplay(detailRequestsSectionElement, arrowRequestsSectionElement);
  setupRequestsData();
});

getRequestsFromJSON();
  
""";

}