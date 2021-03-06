ARG IMAGE

FROM $IMAGE

ARG DEP_INSTALL_CMD

ENV APP_PATH /opt/app

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH
COPY ./ $APP_PATH/

RUN $DEP_INSTALL_CMD
