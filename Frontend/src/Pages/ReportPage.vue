<template>
  <div :class="['container', 'mt-5', isDarkMode ? 'dark-mode' : 'light-mode']">
    <div class="card p-4 shadow mx-auto" style="max-width: 600px;">
      <h1 class="text-center my-2">Hiba bejelentése</h1>

      <!-- Pop-Up Message -->
      <div v-if="showPopup" class="alert alert-danger" role="alert">
        Kérjük, töltse ki az összes kötelező mezőt!
      </div>

      <div v-if="showSuccessPopup" class="alert alert-success" role="alert">
        Hiba sikeresen elküldve!
      </div>

      <div v-if="showImageLimitPopup" class="alert alert-danger" role="alert">
        Maximum 4 képet tölthet fel!
      </div>


      <div class="mb-3 position-relative">
        <label for="bugName" class="form-label">
          Hiba megnevezése <span class="text-danger">*</span>
        </label>
        <input type="text" :class="['form-control', isDarkMode ? 'dark-textbox' : '']" id="bugName" v-model="bugName"
          placeholder="Adja meg a hiba nevét röviden" maxlength="30" required @input="setCookie('bugName', bugName)" />
        <span class="position-absolute top-0 end-0 me-2 mt-1 small" :class="isDarkMode ? 'text-white' : 'text-muted'">
          {{ bugName.length }}/30
        </span>
      </div>

      <div class="mb-3 position-relative">
        <label for="bugDescription" class="form-label">
          Hiba leírása <span class="text-danger">*</span>
        </label>
        <textarea :class="['form-control', isDarkMode ? 'dark-textbox' : '']" id="bugDescription"
          v-model="bugDescription" rows="3" placeholder="Adja meg a hiba leírását" maxlength="250"
          @input="adjustTextareaHeight($event); setCookie('bugDescription', bugDescription);" required>
  </textarea>
        <span class="position-absolute top-0 end-0 me-2 mt-1 small" :class="isDarkMode ? 'text-white' : 'text-muted'">
          {{ bugDescription.length }}/250
        </span>
      </div>

      <div class="row">
        <!-- Left Column: Location, Label, and Priority -->
        <div class="col-md-6">
          <!-- Location Dropdown -->
          <div class="dropdown mb-2">
            <button :class="['btn btn-colorless dropdown-toggle w-100 my-2', isDarkMode ? 'dark-dropdown' : '']" type="button"
              id="locationDropdown" data-bs-toggle="dropdown" aria-expanded="false">
              {{ location || 'Helyszín' }} <span class="text-danger" v-if="!location">*</span>
            </button>
            <ul class="dropdown-menu w-100 scrollable-dropdown" aria-labelledby="locationDropdown">
              <li><a class="dropdown-item text-center" href="#" @click="selectLocation('Első terem')">Első terem</a>
              </li>
              <li><a class="dropdown-item text-center" href="#" @click="selectLocation('Másik terem 2')">Másik terem
                  2</a></li>
              <li><a class="dropdown-item text-center" href="#" @click="selectLocation('Másik terem 3')">Másik terem
                  3</a></li>
              <li><a class="dropdown-item text-center" href="#" @click="selectLocation('Egyéb')">Egyéb</a></li>
            </ul>
          </div>
          <div v-if="showOtherLocation" class="my-3 mt-0">
            <input type="text" :class="['form-control border-secondary', isDarkMode ? 'dark-textbox' : '']"
              id="otherLocation" v-model="otherLocation" placeholder="Adja meg a helyszínt"
              @input="setCookie('otherLocation', otherLocation)">
          </div>

          <!-- Label Dropdown -->
          <div class="dropdown mb-2">
            <button :class="['btn btn-colorless dropdown-toggle w-100 my-2', isDarkMode ? 'dark-dropdown' : '']" type="button"
              id="labelDropdown" data-bs-toggle="dropdown" aria-expanded="false">
              {{ label || 'Címkék' }} <span class="text-danger" v-if="!label">*</span>
            </button>
            <ul class="dropdown-menu w-100" aria-labelledby="labelDropdown">
              <li><a class="dropdown-item text-center" href="#" @click="selectlabel('Hardver')">Hardver</a></li>
              <li><a class="dropdown-item text-center" href="#" @click="selectlabel('Szoftver')">Szoftver</a></li>
              <li><a class="dropdown-item text-center" href="#" @click="selectlabel('Egyéb')">Egyéb</a></li>
            </ul>
          </div>

          <!-- Priority Radio Buttons -->
          <div class="mb-2">
            <label for="priority" class="form-label">Prioritás:</label>
            <div class="d-flex flex-row">
              <div class="form-check me-2">
                <input class="form-check-input" type="radio" v-model="priority" id="priority0" value="0"
                  @change="setCookie('priority', priority)" />
                <label class="form-check-label" for="priority0">Nincs</label>
              </div>
              <div class="form-check me-2" v-for="n in 5" :key="n">
                <input class="form-check-input" type="radio" v-model="priority" :id="'priority' + n" :value="n"
                  @change="setCookie('priority', priority)" />
                <label class="form-check-label" :for="'priority' + n">{{ n }}</label>
              </div>
            </div>
          </div>
        </div>

        <!-- Right Column: Picture Upload Button aligned with Location -->
        <div class="col-md-6">
          <div>
            <label for="photo" class="btn btn-primary pictureUploadButton w-100 ">Kép feltöltése</label>
            <input type="file" class="form-control" id="photo" @change="onFileChange" accept=".png, .jpg, .jpeg, .heic"
              multiple style="display: none;">
          </div>
          <div class="image-preview-container mt-3">
            <div v-for="(photo, index) in photoPreviews" :key="index" class="image-preview">
              <img :src="photo" class="img-thumbnail" alt="Preview" />
              <button type="button" class="btn btn-danger btn-sm" @click="removePhoto(index)">X</button>
            </div>
          </div>

        </div>
      </div>
<!-- Pop-Up Message for Confirm Reset -->
<div v-if="showResetPopup" class="alert alert-warning d-flex justify-content-between align-items-center" role="alert">
  <div>Biztosan törölni szeretné az összes adatot?</div>
  <div class="d-flex">
    <button class="btn btn-colorless  mx-4" @click="resetData">Igen</button>
    <button class="btn btn-colorless  ml-2" @click="cancelReset">Nem</button>
  </div>
</div>
<!-- Success Message after Data Reset -->
<div v-if="showSuccessResetPopup" class="alert alert-success" role="alert">
  Adatok sikeresen törölve!
</div>

      <div class="d-grid gap-2 d-flex justify-content-center my-3">
        <button type="button" class="btn btn-secondary w-100" @click="confirmReset">Adatok törlése</button>
        <button type="submit" class="btn btn-primary w-100" @click="bekuldes">Hiba beküldése</button>
      </div>
    </div>
  </div>
</template>





<script>
import axios from 'axios';
import CryptoJS from 'crypto-js';

export default {
  data() {
    return {
      bugName: this.getCookie('bugName') || '',
      priority: this.getCookie('priority') || '0',
      bugDescription: this.getCookie('bugDescription') || '',
      photos: [],
      photoPreviews: [],
      location: this.getCookie('location') || '',
      label: this.getCookie('label') || '',
      showOtherLocation: false,
      otherLocation: this.getCookie('otherLocation') || '',
      showPopup: false, 
      showSuccessPopup: false,
      showSuccessResetPopup: false,
      showResetPopup: false,
      isDarkMode: false,
      showImageLimitPopup: false,

    };
  },

  mounted() {
    this.isDarkMode = sessionStorage.getItem('theme') === 'dark';
    window.addEventListener('theme-changed', this.updateTheme);
  },
  beforeDestroy() {
    window.removeEventListener('theme-changed', this.updateTheme);
  },
  methods: {
    setCookie(name, value, days = 7) {
      const d = new Date();
      d.setTime(d.getTime() + (days * 24 * 60 * 60 * 1000));
      const expires = "expires=" + d.toUTCString();
      document.cookie = name + "=" + value + ";" + expires + ";path=/";
    },
    getCookie(name) {
      const nameEQ = name + "=";
      const ca = document.cookie.split(';');
      for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
      }
      return '';
    },


    onFileChange(event) {
      const files = event.target.files;
      if (files.length + this.photos.length > 4) {
        this.showImageLimitPopup = true; 

        event.target.value = "";

        setTimeout(() => {
          this.showImageLimitPopup = false;
        }, 5000);
        return;
      }

      for (let i = 0; i < files.length; i++) {
        const file = files[i];

        const hashedName = CryptoJS.MD5(file.name).toString();

        const newFile = new File([file], hashedName + '.' + file.name.split('.').pop(), {
          type: file.type,
        });

        this.photos.push(newFile);

        const reader = new FileReader();
        reader.onload = (e) => {
          this.photoPreviews.push(e.target.result);
        };
        reader.readAsDataURL(file);
      }
    },

    removePhoto(index) {
      this.photos.splice(index, 1);
      this.photoPreviews.splice(index, 1);
    },
    reset() {
      this.bugName = '';
      this.priority = '0';
      this.bugDescription = '';
      this.photos = [];
      this.photoPreviews = [];
      this.location = '';
      this.label = '';
      this.showOtherLocation = false;
      this.otherLocation = '';
      this.showPopup = false; 

      this.setCookie('bugName', '');
      this.setCookie('priority', '0');
      this.setCookie('bugDescription', '');
      this.setCookie('location', '');
      this.setCookie('label', '');
      this.setCookie('otherLocation', '');
    },
    updateTheme() {
      this.isDarkMode = sessionStorage.getItem('theme') === 'dark';
    },
    adjustTextareaHeight(event) {
      const textarea = event.target;
      textarea.style.height = 'auto'; 
      textarea.style.height = `${textarea.scrollHeight}px`; 
    },
    selectLocation(selectedLocation) {
      this.location = selectedLocation;
      this.showOtherLocation = selectedLocation === 'Egyéb';
      this.setCookie('location', selectedLocation);
    },
    selectlabel(selectedlabel) {
      this.label = selectedlabel;
      this.setCookie('label', selectedlabel);
    },
    bekuldes() {
      if (!this.bugName || !this.bugDescription || !this.location || !this.label || this.location === 'Egyéb' && !this.otherLocation) {
        this.showPopup = true; 
        setTimeout(() => {
          this.showPopup = false;
        }, 5000);
        return;
      }

      const username = sessionStorage.getItem('username');
      if (!username) {
        alert('No user logged in');
        return;
      }

      const formData = new FormData();
      formData.append('bugName', this.bugName);
      formData.append('bugDescription', this.bugDescription);
      formData.append('reported_by', username);
      formData.append('location', this.location === 'Egyéb' ? this.otherLocation : this.location);
      formData.append('priority', this.priority);
      formData.append('label', this.label);
      this.photos.forEach(photo => {
        formData.append('photos', photo);
      });

      axios.post("http://localhost:4500/api/bugReport", formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      })
        .then((res) => {
          if (res.data.msg === "Validation Failed") {
          } else {
            this.showSuccessPopup = true;
            setTimeout(() => {
              this.showSuccessPopup = false;
            }, 5000);
            this.reset(); 
          }
        })
        .catch((error) => {
          console.error('Error submitting bug report:', error);
          alert('Error: Unable to submit bug report.');
        });
    },
    confirmReset() {
      this.showResetPopup = true;
    },
    resetData() {
      this.bugName = '';
      this.priority = '0';
      this.bugDescription = '';
      this.photos = [];
      this.photoPreviews = [];
      this.location = '';
      this.label = '';
      this.showOtherLocation = false;
      this.otherLocation = '';
      
      this.setCookie('bugName', '');
      this.setCookie('priority', '0');
      this.setCookie('bugDescription', '');
      this.setCookie('location', '');
      this.setCookie('label', '');
      this.setCookie('otherLocation', '');
      console.log('Adatok törölve!');
      
      this.showResetPopup = false; 
      this.showSuccessResetPopup = true; 

      setTimeout(() => {
        this.showSuccessResetPopup = false;
      }, 5000);
    },

    cancelReset() {
      this.showResetPopup = false; 
  }},
  }
</script>

<style scoped>
.alert-success {
  background-color: #d4edda; 
  color: #155724;
  border-color: #c3e6cb;
  margin-top: 0;
  margin-bottom: 0;
  max-height: fit-content;
}

.image-preview-container {
  margin-left: 3rem;
  display: flex;
  gap: 5px;
  flex-wrap: wrap;
}

.image-preview {
  position: relative;
  width: 85px;
  height: 85px;
}

.img-thumbnail {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border: none !important;
  box-shadow: none !important;
  padding: 0 !important;
  margin: 0;
  background-color: transparent;
}

.btn-danger {
  position: absolute;
  top: 0;
  right: 0;
  padding: 2px 4px;
  font-size: 10px;
}

.btn-colorless{
  border: gray 1px solid;
  background-color: white;
}


.pictureUploadButton {
  margin-top: 0.5rem;
  padding: 5px;
  font-size: 1.1rem;
  border-radius: 5px;
  transition: background-color 0.3s ease;
  text-align: center;
  border: px solid black;
  background-color: #4285f4;
  border-color: #4285f4;
  color: white;
}

.alert {
  margin-top: 10px;
  margin-bottom: 0;
  max-height: fit-content;
} 

.search-input {
  width: 200px;
  border: solid 2px #4285f4;
}

.filter-icon {
  font-size: 1.5rem;
  color: #4285f4;
}

.dropdown-toggle {
  border: 1px solid black;
}

.dropdown-menu {
  border: 1px solid black;
}

.dark-dropdown {
  background-color: #444;
  color: white;
  border: 1px solid #777;
}

.dark-dropdown .dropdown-item:hover {
  background-color: #555;
}

.dark-textbox {
  background-color: #444;
  color: white;
  border: 1px solid #777;
}
#bugName::placeholder {
  color: rgb(168, 168, 168);
}

#bugDescription::placeholder {
  color: rgb(168, 168, 168);
}

#otherLocation::placeholder {
  color: rgb(168, 168, 168);
}

.dropdown-item {
  width: auto !important;
  min-width: unset !important;
}

.text-muted {
  color: #6c757d !important;
}

.text-white {
  color: #dcdcdc !important;
}
.btn-colorless:hover {
  background-color: gray;
  border-color: unset;
  color: white;
}

textarea{
  overflow: hidden; 
}

.scrollable-dropdown {
  max-height: 200px;
  overflow-y: auto;
}
</style>
